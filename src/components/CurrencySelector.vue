<template>
  <div class="relative max-w-md bg-slate-100 outline outline-1 outline-solid outline-slate-400 hover:outline-slate-500 select-none" :class="{ rounded: !isOpen, 'rounded-t': isOpen }" tabindex="0" @blur="toggleList">
    <div class="flex flex-wrap p-2.5">
      <input class="grow bg-inherit focus:outline-none focus-visible:outline-none" v-model.number="amount" placeholder="0"/>
      <div class="w-40 min-w-fit" @click="toggleList">{{ selected.ticker }}</div>
    </div>
    <div class="absolute bg-inherit left-0 right-0 overflow-hidden outline outline-1 rounded-b outline-solid outline-slate-400 hover:outline-slate-500 z-10" :class="{ hidden: !isOpen }">
      <div 
        v-for="(currency, index) in currencies"
        :key="index"
        @click="setSelected(currency)"
        class="hover:bg-sky-200 p-2.5"
      >
        {{ currency.ticker }} | {{ currency.name }}
      </div>
    </div>
  </div>
</template>

<script>

export default {
  props: ['currencies'],
  
  data() {
    return {
      selected: { ticker: 'sel' },
      amount: null,
      isOpen: false,
    }
  },

  methods: {
    setSelected(currency) {
      this.selected = currency;
      this.toggleList();
    },
    toggleList() {
      this.isOpen = !this.isOpen;
    }
  }
}
</script>

<style scoped>

</style>