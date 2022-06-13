<template>
  <p>Wallet Address</p>
  <div class="flex items-start gap-5 flex-wrap md:flex-nowrap">
    <input class="input rounded min-w-0 grow" />
    <div class="grow md:grow-0 flex flex-col items-center">
      <button class="btn w-full md:w-60" :disabled="error">Exchange</button>
      <p v-if="error" class="text-red-500">This pair is disabled now</p>
    </div>
  </div>
</template>

<script>
export default {
  props: [ 'error' ],
}
</script>

<style>

</style>