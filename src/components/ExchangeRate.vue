<template>
  <CurrencySelector :currencies="availableCurrencies"/>
  <CurrencySelector :currencies="availableCurrencies"/>
</template>

<script>
import axios from 'axios';
import CurrencySelector from './CurrencySelector.vue';

export default {
  components: { CurrencySelector },

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