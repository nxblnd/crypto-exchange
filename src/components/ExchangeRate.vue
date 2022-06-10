<template>
  <div class="flex flex-col md:flex-row items-center my-5">
    <CurrencySelector :currencies="availableCurrencies"/>
    <SwitchVerticalIcon class="shrink-0 w-8 h-8 m-3 text-sky-500 md:rotate-90" />
    <CurrencySelector :currencies="availableCurrencies"/>
  </div>
</template>

<script>
import axios from 'axios';
import CurrencySelector from './CurrencySelector.vue';
import { SwitchVerticalIcon } from '@heroicons/vue/outline'

export default {
  components: { CurrencySelector, SwitchVerticalIcon },

  data() {
    return {
      availableCurrencies: null,
    }
  },

  mounted() {
    axios
      .get('https://api.changenow.io/v1/currencies?active=true')
      .then(res => this.availableCurrencies = res.data);
  }
}
</script>

<style>

</style>