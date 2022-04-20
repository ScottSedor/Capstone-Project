<template>
  <div class="home">
    <h1>Home</h1>
    <p>You must be authenticated to see this</p>
    <router-link :to="{name: 'decks'}">
      <button id="decks">
        <img class="studio-img" data-toggle="popover" title="View All Decks" src="..\assets\blank-white-studio.jpg" alt="blank white study">
      </button>
    </router-link>  
    <router-link :to="{name: 'study-session-home'}">
      <button id="start-study-button">
        <img class="start-study-img" data-toggle="popover" title="Start Study Session" src="..\assets\play-button-icon.png" alt="play button icon">
      </button>
    </router-link>
  </div>
</template>

<script>
export default {
  name: "home"
};
</script>

<style>
  div > h1 {
    color: #274e13ff;
  }
  div > p {
    color: #274e13ff;
  }
  div.deck-list {
    color:  #274e13ff;
  }
  div.study-session-home {
    color:  #274e13ff;
  }
</style>
