<template>
  <el-card class="table-card" v-loading="result.loading">
    <template v-slot:header>
      <span class="title">{{$t('commons.test')}}</span>
    </template>
    <el-table :data="tableData" class="table-content">
      <el-table-column :label="$t('commons.name')" width="150" show-overflow-tooltip>
        <template v-slot:default="scope">
          <el-link type="info" @click="link(scope.row)">{{ scope.row.name }}</el-link>
        </template>
      </el-table-column>
      <el-table-column prop="projectName" :label="$t('load_test.project_name')" width="150" show-overflow-tooltip/>
      <el-table-column width="250" :label="$t('commons.create_time')">
        <template v-slot:default="scope">
          <span>{{ scope.row.createTime | timestampFormatDate }}</span>
        </template>
      </el-table-column>
      <el-table-column width="250" :label="$t('commons.update_time')">
        <template v-slot:default="scope">
          <span>{{ scope.row.updateTime | timestampFormatDate }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="status" :label="$t('commons.status')">
        <template v-slot:default="{row}">
          <ms-performance-test-status :row="row"/>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script>

  import MsPerformanceTestStatus from "../test/PerformanceTestStatus";

  export default {
    name: "MsPerformanceTestRecentList",
    components: {MsPerformanceTestStatus},
    data() {
      return {
        result: {},
        tableData: []
      }
    },

    methods: {
      search() {
        this.result = this.$get("/performance/recent/5", response => {
          this.tableData = response.data;
        });
      },
      link(row) {
        this.$router.push({
          path: '/performance/test/edit/' + row.id,
        })
      }
    },

    created() {
      this.search();
    }
  }
</script>

<style scoped>

</style>
