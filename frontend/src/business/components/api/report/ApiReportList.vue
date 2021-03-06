<template>
  <ms-container>
    <ms-main-container>
      <el-card class="table-card" v-loading="result.loading">
        <template v-slot:header>
          <ms-table-header :condition.sync="condition" @search="search" :title="$t('api_report.title')"
                           :show-create="false"/>
        </template>
        <el-table :data="tableData" class="table-content">
          <el-table-column :label="$t('commons.name')" width="200" show-overflow-tooltip>
            <template v-slot:default="scope">
              <el-link type="info" @click="handleView(scope.row)">{{ scope.row.name }}</el-link>
            </template>
          </el-table-column>
          <el-table-column prop="testName" :label="$t('api_report.test_name')" width="200" show-overflow-tooltip/>
          <el-table-column prop="projectName" :label="$t('load_test.project_name')" width="150" show-overflow-tooltip/>
          <el-table-column prop="userName" :label="$t('api_test.creator')" width="150" show-overflow-tooltip/>
          <el-table-column width="250" :label="$t('commons.create_time')">
            <template v-slot:default="scope">
              <span>{{ scope.row.createTime | timestampFormatDate }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="status" :label="$t('commons.status')">
            <template v-slot:default="{row}">
              <ms-api-report-status :row="row"/>
            </template>
          </el-table-column>
          <el-table-column width="150" :label="$t('commons.operating')">
            <template v-slot:default="scope">
              <el-button @click="handleView(scope.row)" type="primary" icon="el-icon-s-data" size="mini" circle/>
              <el-button @click="handleDelete(scope.row)" type="danger" icon="el-icon-delete" size="mini" circle/>
            </template>
          </el-table-column>
        </el-table>
        <ms-table-pagination :change="search" :current-page.sync="currentPage" :page-size.sync="pageSize"
                             :total="total"/>
      </el-card>
    </ms-main-container>
  </ms-container>
</template>

<script>
  import MsTablePagination from "../../common/pagination/TablePagination";
  import MsTableHeader from "../../common/components/MsTableHeader";
  import MsContainer from "../../common/components/MsContainer";
  import MsMainContainer from "../../common/components/MsMainContainer";
  import MsApiReportStatus from "./ApiReportStatus";

  export default {
    components: {MsApiReportStatus, MsMainContainer, MsContainer, MsTableHeader, MsTablePagination},
    data() {
      return {
        result: {},
        condition: {name: ""},
        tableData: [],
        multipleSelection: [],
        currentPage: 1,
        pageSize: 5,
        total: 0,
        loading: false
      }
    },

    watch: {
      '$route': 'init',
    },

    methods: {
      search() {
        let param = {
          name: this.condition.name,
        };

        if (this.testId !== 'all') {
          param.testId = this.testId;
        }

        let url = "/api/report/list/" + this.currentPage + "/" + this.pageSize
        this.result = this.$post(url, param, response => {
          let data = response.data;
          this.total = data.itemCount;
          this.tableData = data.listObject;
        });
      },
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      handleView(report) {
        this.$router.push({
          path: '/api/report/view/' + report.id,
        })
      },
      handleDelete(report) {
        this.$alert(this.$t('api_report.delete_confirm') + report.name + "？", '', {
          confirmButtonText: this.$t('commons.confirm'),
          callback: (action) => {
            if (action === 'confirm') {
              this.result = this.$post("/api/report/delete", {id: report.id}, () => {
                this.$success(this.$t('commons.delete_success'));
                this.search();
              });
            }
          }
        });
      },
      init() {
        this.testId = this.$route.params.testId;
        this.search();
      }
    },

    created() {
      this.init();
    }
  }
</script>

<style scoped>
  .table-content {
    width: 100%;
  }
</style>
