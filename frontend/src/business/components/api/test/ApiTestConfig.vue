<template>
  <div class="container">
    <div class="main-content">
      <el-card>
        <el-container class="test-container" v-loading="result.loading">
          <el-header>
            <el-row type="flex" align="middle">
              <el-input class="test-name" v-model="test.name" maxlength="64" :placeholder="$t('api_test.input_name')">
                <el-select class="test-project" v-model="test.projectId" slot="prepend"
                           :placeholder="$t('api_test.select_project')">
                  <el-option v-for="project in projects" :key="project.id" :label="project.name" :value="project.id"/>
                </el-select>
              </el-input>
              <el-button type="primary" plain :disabled="isDisabled" @click="saveTest">保存</el-button>
            </el-row>
          </el-header>
          <ms-api-scenario-config :scenarios="test.scenarioDefinition"/>
        </el-container>
      </el-card>
    </div>
  </div>
</template>

<script>
  import MsApiScenarioConfig from "./components/ApiScenarioConfig";

  export default {
    name: "MsApiTestConfig",

    components: {MsApiScenarioConfig},

    data() {
      return {
        result: {},
        projects: [],
        change: false,
        test: {
          id: null,
          projectId: null,
          name: null,
          scenarioDefinition: []
        }
      }
    },

    watch: {
      test: {
        handler: function () {
          this.change = true;
        },
        deep: true
      }
    },

    methods: {
      saveTest: function () {
        this.change = false;

        let param = {
          id: this.test.id,
          projectId: this.test.projectId,
          name: this.test.name,
          scenarioDefinition: JSON.stringify(this.test.scenarioDefinition)
        }

        this.result = this.$post("/api/save", param, response => {
          this.test.id = response.data;
          this.$message({
            message: this.$t('commons.save_success'),
            type: 'success'
          });
        });
      }
    },

    computed: {
      isDisabled() {
        return !(this.test.projectId && this.test.name && this.change)
      }
    },

    created() {
      this.result = this.$get("/project/listAll", response => {
        this.projects = response.data;
      })
    }
  }
</script>

<style scoped>
  .test-container {
    height: calc(100vh - 150px);
    min-height: 600px;
  }

  .test-name {
    width: 600px;
    margin-left: -20px;
    margin-right: 20px;
  }

  .test-project {
    min-width: 150px;
  }
</style>