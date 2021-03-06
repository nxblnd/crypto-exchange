<template>
  <div class="relative flex-auto md:basis-96 group input select-none" :class="{ rounded: !isOpen, 'rounded-t': isOpen }" tabindex="0">
    <div v-if="!isOpen" class="flex">
      <input class="w-0 flex-auto bg-inherit focus:outline-none focus-visible:outline-none placeholder:text-slate-400" :value="currency.amount" @blur="$emit('update:currency', { currency: selected.ticker, amount: $event.target.value })" placeholder="0"/>
      <div class="flex justify-center gap-5 max-w-2xl before:block before:border-l before:border-solid before:border-slate-400" @click="showList">
        <template v-if="selected">
          <img class="h-5" :src="selected.image" />
          <p>{{ selected.ticker.toUpperCase() }}</p>
        </template>
        <template v-else>
          <p class="text-slate-400">BTC</p>
        </template>
        <div class="self-center h-5 w-5 text-slate-500">
          <ChevronDownIcon v-if="!isOpen" />
          <XIcon v-if="isOpen" />
        </div>
      </div>
    </div>
    <div v-if="isOpen" class="bg-inherit">
      <input class="w-full bg-inherit flex-auto focus:outline-none focus-visible:outline-none placeholder:text-slate-400" v-model="filter" ref="filterInput" placeholder="Search"/>
      <div class="absolute bg-inherit left-0 right-0 mt-2.5 max-h-96 overflow-y-auto outline outline-1 rounded-b outline-solid outline-slate-400 group-focus:outline-slate-500 z-10" :class="{ hidden: !isOpen }">
        <div 
          v-for="(currency, index) in filteredCurrenciesList"
          :key="index"
          @click="setSelected(currency)"
          class="flex gap-5 hover:bg-sky-200 p-2.5"
        >
          <img class="h-5" :src="currency.image" />
          <p>{{ currency.ticker.toUpperCase() }}</p>
          <p class="text-slate-400">{{ currency.name }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ChevronDownIcon, XIcon } from '@heroicons/vue/solid'

export default {
  components: { ChevronDownIcon, XIcon },

  props: ['currenciesList', 'currency'],
  emits: ['update:currency'],
  
  data() {
    return {
      selected: null,
      amount: null,
      isOpen: false,
      filter: '',
    }
  },

  computed: {
    filteredCurrenciesList() {
      if (!this.filter) return this.currenciesList;
      const filterRegex = new RegExp(this.filter, 'i');
      return this.currenciesList.filter(currency => filterRegex.test(currency.ticker) || filterRegex.test(currency.name));
    }
  },

  methods: {
    setSelected(currency) {
      this.selected = currency;
      this.filter = '';
      this.toggleList();
      this.$emit('update:currency', { currency: currency.ticker, amount: this.amount });
    },
    showList() {
      this.toggleList();
      this.$nextTick(() => this.$refs.filterInput.focus());
    },
    toggleList() {
      this.isOpen = !this.isOpen;
    }
  },
}
</script>

<style scoped>

</style>