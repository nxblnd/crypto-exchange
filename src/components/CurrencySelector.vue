<template>
  <div class="relative group w-96 input select-none" :class="{ rounded: !isOpen, 'rounded-t': isOpen }" tabindex="0" @blur="isOpen = false">
    <div class="flex">
      <input class="grow bg-inherit focus:outline-none focus-visible:outline-none placeholder:text-slate-400" :value="currency.amount" @blur="$emit('update:currency', { currency: selected.ticker, amount: $event.target.value })" placeholder="0"/>
      <div class="flex justify-center gap-5 max-w-2xl before:block before:border-l before:border-solid before:border-slate-400" @click="toggleList">
        <template v-if="selected">
          <svg class="self-center ml-auto h-5 w-5" xmlns="http://www.w3.org/2000/svg">
            <image class="m-1" :href="selected.image" />
          </svg>
          <p>{{ selected.ticker.toUpperCase() }}</p>
        </template>
        <template v-else>
          <p class="ml-auto text-slate-400">BTC</p>
        </template>
        <div class="ml-auto self-center h-5 w-5 text-slate-500">
          <ChevronDownIcon v-if="!isOpen" />
          <XIcon v-if="isOpen" />
        </div>
      </div>
    </div>
    <div class="absolute bg-inherit left-0 right-0 max-h-96 overflow-y-auto outline outline-1 rounded-b outline-solid outline-slate-400 group-hover:outline-slate-500 z-10" :class="{ hidden: !isOpen }">
      <div 
        v-for="(currency, index) in currenciesList"
        :key="index"
        @click="setSelected(currency)"
        class="flex gap-5 hover:bg-sky-200 p-2.5"
      >
        <svg class="self-center h-5 w-5" xmlns="http://www.w3.org/2000/svg">
          <image class="m-1" :href="currency.image" />
        </svg>
        <p>{{ currency.ticker.toUpperCase() }}</p>
        <p class="text-slate-400">{{ currency.name }}</p>
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
    }
  },

  methods: {
    setSelected(currency) {
      this.selected = currency;
      this.toggleList();
      this.$emit('update:currency', { currency: currency.ticker, amount: this.amount });
    },
    toggleList() {
      this.isOpen = !this.isOpen;
    }
  }
}
</script>

<style scoped>

</style>