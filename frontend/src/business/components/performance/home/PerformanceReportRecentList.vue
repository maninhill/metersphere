<template>
  <el-card class="table-card" v-loading="result.loading">
    <template v-slot:header>
      <span class="title">{{$t('api_report.title')}}</span>
    </template>
    <el-table :data="tableData" class="table-content">
      <el-table-column :label="$t('commons.name')" width="150" show-overflow-tooltip>
        <template v-slot:default="scope">
          <el-link type="info" @click="link(scope.row)">{{ scope.row.name }}</el-link>
        </template>
      </el-table-column>
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
          <ms-performance-report-status :row="row"/>
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script>

  import MsPerformanceReportStatus from "../report/PerformanceReportStatus";

  export default {
    name: "MsPerformanceReportRecentList",
    components: {MsPerformanceReportStatus},
    data() {
      return {
        result: {},
        tableData: []
      }
    },

    methods: {
      search() {
        this.result = this.$get("/performance/report/recent/5", response => {
          this.tableData = response.data;
        });
      },
      link(row) {
        this.$router.push({
          path: '/performance/report/view/' + row.id,
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
