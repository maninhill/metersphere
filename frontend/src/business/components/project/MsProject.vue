<template>
  <ms-container>
    <ms-main-container>
      <el-card class="table-card" v-loading="result.loading">
        <template v-slot:header>
          <ms-table-header :condition.sync="condition" @search="search" @create="create"
                           :create-tip="btnTips" :title="title"/>
        </template>
        <el-table :data="items" style="width: 100%">
          <el-table-column prop="name" :label="$t('commons.name')"/>
          <el-table-column prop="description" :label="$t('commons.description')"/>
          <!--<el-table-column prop="workspaceName" :label="$t('project.owning_workspace')"/>-->
          <el-table-column>
            <template v-slot:default="scope">
              <ms-table-operator @editClick="edit(scope.row)" @deleteClick="del(scope.row)"/>
            </template>
          </el-table-column>
        </el-table>
        <ms-table-pagination :change="list" :current-page.sync="currentPage" :page-size.sync="pageSize"
                             :total="total"/>
      </el-card>
    </ms-main-container>

    <el-dialog :title="title" :visible.sync="createVisible">
      <el-form :model="form" :rules="rules" ref="form" label-position="right" label-width="100px" size="small">
        <el-form-item :label="$t('commons.name')">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item :label="$t('commons.description')">
          <el-input type="textarea" v-model="form.description"></el-input>
        </el-form-item>
      </el-form>
      <template v-slot:footer>
        <div class="dialog-footer">
          <ms-dialog-footer
            @cancel="createVisible = false"
            @confirm="submit('form')"/>
        </div>
      </template>
    </el-dialog>

  </ms-container>
</template>

<script>
  import MsCreateBox from "../settings/CreateBox";
  import {Message} from "element-ui";
  import MsTablePagination from "../common/pagination/TablePagination";
  import MsTableHeader from "../common/components/MsTableHeader";
  import MsTableOperator from "../common/components/MsTableOperator";
  import MsDialogFooter from "../common/components/MsDialogFooter";
  import {getCurrentUser} from "../../../common/js/utils";
  import MsContainer from "../common/components/MsContainer";
  import MsMainContainer from "../common/components/MsMainContainer";

  export default {
    name: "MsProject",
    components: {
      MsMainContainer,
      MsContainer, MsTableOperator, MsCreateBox, MsTablePagination, MsTableHeader, MsDialogFooter},
    data() {
      return {
        createVisible: false,
        result: {},
        btnTips: this.$t('project.create'),
        title: this.$t('project.create'),
        condition: {},
        items: [],
        form: {},
        currentPage: 1,
        pageSize: 5,
        total: 0,
        rules: {
          name: [
            {required: true, message: this.$t('project.input_name'), trigger: 'blur'},
            {min: 2, max: 50, message: this.$t('commons.input_limit', [2, 50]), trigger: 'blur'}
          ]
        },
      }
    },
    props: {
      baseUrl: {
        type: String
      }
    },
    mounted() {
      if (this.$route.path.split('/')[2] === 'project' &&
        this.$route.path.split('/')[3] === 'create') {
        this.create();
        this.$router.push('/' + this.baseUrl + '/project/all');
      }
      this.list();
    },
    watch: {
      '$route'(to) {
        if (this.$route.path.split('/')[2] === 'project' &&
          to.path.split('/')[3] === 'create') {
          this.create();
          this.$router.push('/' + this.baseUrl + '/project/all');
        }
      }
    },
    computed: {
      currentUser: () => {
        return getCurrentUser();
      }
    },
    destroyed() {
      this.createVisible = false;
    },
    methods: {
      create() {
        let workspaceId = this.currentUser.lastWorkspaceId;
        if (!workspaceId) {
          this.$warning(this.$t('project.please_choose_workspace'));
          return false;
        }
        this.title = this.$t('project.create');
        this.createVisible = true;
        this.form = {};
      },
      edit(row) {
        this.title = this.$t('project.edit');
        this.createVisible = true;
        this.form = Object.assign({}, row);
      },
      submit(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            let saveType = "add";
            if (this.form.id) {
              saveType = "update"
            }
            this.result = this.$post("/project/" + saveType, this.form, () => {
              this.createVisible = false;
              this.list();
              Message.success(this.$t('commons.save_success'));
            });
          } else {
            return false;
          }
        });
      },
      del(row) {
        this.$confirm(this.$t('project.delete_confirm'), this.$t('commons.prompt'), {
          confirmButtonText: this.$t('commons.confirm'),
          cancelButtonText: this.$t('commons.cancel'),
          type: 'warning'
        }).then(() => {
          this.$get('/project/delete/' + row.id, () => {
            Message.success(this.$t('commons.delete_success'));
            this.list();
          });
        }).catch(() => {
        });
      },
      search() {
        this.list();
      },
      list() {
        let url = "/project/list/" + this.currentPage + '/' + this.pageSize;
        this.result = this.$post(url, this.condition, (response) => {
          let data = response.data;
          this.items = data.listObject;
          this.total = data.itemCount;
        })
      },
    }
  }
</script>

<style scoped>

</style>
