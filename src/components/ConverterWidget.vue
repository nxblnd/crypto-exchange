<template>
  <div class="flex flex-col items-stretch md:flex-row md:items-center my-5">
    <CurrencySelector :currenciesList="availableCurrencies" v-model:currency="leftCurrency" @update:currency="calculate" />
    <SwitchVerticalIcon class="shrink-0 w-8 h-8 m-3 text-sky-500 place-self-center md:rotate-90" />
    <CurrencySelector :currenciesList="availableCurrencies" v-model:currency="rightCurrency" @update:currency="calculate" />
  </div>
  <Transition name="slide">
    <p class="error" v-if="errors.tooLittle">Error: minimal amount for conversion is {{ minimalAmount }} {{ this.leftCurrency.currency.toUpperCase() }}</p>
  </Transition>
  <WalletAddress :error="errors.pairDisabled" />
</template>

<script>
import axios from 'axios';
import CurrencySelector from './CurrencySelector.vue';
import WalletAddress from './WalletAddress.vue';
import { SwitchVerticalIcon } from '@heroicons/vue/outline'

const API_KEY = 'c9155859d90d239f909d2906233816b26cd8cf5ede44702d422667672b58b0cd';

export default {
  components: { CurrencySelector, WalletAddress, SwitchVerticalIcon },

  data() {
    return {
      availableCurrencies: null,
      leftCurrency: { amount: null, currency: null },
      rightCurrency: { amount: null, currency: null },
      minimalAmount: null,
      errors: {
        tooLittle: false,
        pairDisabled: false,
      },
    }
  },

  methods: {
    async calculate() {
      if (this.leftCurrency.currency === null || this.rightCurrency.currency === null) return;

      try {
        this.minimalAmount = await this.getMinAmount();
      } catch (error) {
        if (error === 'pair_is_inactive') {
          this.errors.pairDisabled = true;
          return;
        }
      }
      this.errors.pairDisabled = false;
      
      this.leftCurrency.amount = this.leftCurrency.amount || this.minimalAmount;
      if (this.leftCurrency.amount < this.minimalAmount) {
        this.rightCurrency.amount = "---";
        this.errors.tooLittle = true;
        return;
      }
      this.errors.tooLittle = false;
      this.rightCurrency.amount = await this.convert();
    },
    async getMinAmount() {
      try {
        const res = await axios.get(`https://api.changenow.io/v1/min-amount/${this.leftCurrency.currency}_${this.rightCurrency.currency}?api_key=${API_KEY}`);
        return res.data.minAmount;
      } catch (error) {
        if (error.response) throw error.response.data.error;
      }
    },
    async convert() {
      const res = await axios.get(`https://api.changenow.io/v1/exchange-amount/${this.leftCurrency.amount}/${this.leftCurrency.currency}_${this.rightCurrency.currency}?api_key=${API_KEY}`);
      return res.data.estimatedAmount;
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