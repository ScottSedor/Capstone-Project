<template>
  <div class="search-card">
      <form v-on:submit.prevent="search" >
        <label for="search-field" >Search Keyword:</label>
        <input id="search-field" type="text" placeholder="Keyword" v-model.trim="searchRequest.keyword">
        <input type="submit" value="Search" >
      </form>
  </div>
</template>

<script>
export default {
    data() {
        return {
            searchRequest: {
                keyword: ""
            },
        }
    },
    methods: {
        search() {
            
        }
    }
}
</script>

<style>

</style>