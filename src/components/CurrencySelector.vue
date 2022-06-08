<template>
  <select v-model="selected">
      <option v-for="currency in currencies" :key="currency.ticker">{{ currency.ticker }} | {{ currency.name }}</option>
  </select>
</template>

<script>

export default {
  props: ['currencies']
}
</script>

<style>

</style>