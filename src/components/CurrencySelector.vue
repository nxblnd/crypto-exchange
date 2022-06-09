<template>
  <div class="currency-selector relative">
    <div class="selected flex">
      <input class="amount bg-inherit" v-model.number="amount" placeholder="0"/>
      <div class="currency" @click="toggleList">{{ selected.ticker }}</div>
    </div>
    <div class="available-items absolute" :class="{ hidden: !isOpen }">
      <div 
        v-for="(currency, i) in currencies"
        :key="i"
        @click="setSelected(currency)"
        class="hover:bg-sky-200"
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
.hidden {
  display: none;
}

</style>