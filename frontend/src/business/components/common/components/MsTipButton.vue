<template>

  <el-tooltip :disabled="disabled"
              :content="tip"
              placement="bottom"
              :effect="effect">
    <el-button @click="exec()"
               @click.stop="clickStop"
               @keydown.enter.native.prevent
               circle
               :type="type"
               :icon="icon"
               :size="size"/>
  </el-tooltip>

</template>

<script>
    export default {
      name: "MsTipButton",
      props: {
        tip: String,
        icon: {
          type: String,
          default: 'el-icon-question'
        },
        type: {
          type: String,
          default: null
        },
        effect: {
          type: String,
          default: 'dark'
        },
        size: {
          type: String,
          default: 'mini'
        },
        disabled: {
          type: Boolean,
          default: false
        }
      },
      methods: {
        exec() {
          this.$emit('click');
        },
        clickStop() {
          this.$emit('clickStop');
        }
      }
    }
</script>

<style scoped>

</style>
