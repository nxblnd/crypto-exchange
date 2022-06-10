<template>
  <header class="container mx-auto p-4">
    <h1 class="text-5xl font-light leading-relaxed">Crypto Exchange</h1>
    <p class="text-xl">Exchange fast and easy</p>
  </header>

  <main class="container mx-auto p-4">
    <ConverterWidget />
  </main>
</template>

<script setup>
  import ConverterWidget from './components/ConverterWidget.vue';
</script>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Vollkorn&display=swap');
  
  body {
    font-family: 'Vollkorn', serif;
  }
</style>
