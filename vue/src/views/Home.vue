<template>
  <div class="home">
    <h1>Welcome To Stud.io!</h1>
    <p class="subtitle">Choose an Option to Begin Studying</p>

    <div class="home-buttons">
    <router-link :to="{name: 'decks'}">
      <button id="decks">
        <img class="studio-img" data-toggle="popover" title="View All Decks" src="..\assets\blankstudio.jpg" alt="blank white study">
      </button>
    </router-link>
    
    <router-link :to="{name: 'study-session-home'}">
      <button id="start-study-button">
        <img class="start-study-img" data-toggle="popover" title="Start Study Session" src="..\assets\play-button-icon.png" alt="play button icon">
      </button>
    </router-link>
    </div>
    
    <div class="option-text">
      <p class="">Look at your flashcard decks</p>
      <p>Start a study session now</p> 
    
    </div>
  </div>
</template>

<script>
export default {
  name: "home"
};
</script>

<style>
  div.option-text {
    display: flex;
    justify-content: space-evenly;
  }
  div.home > h1 {
    margin-top: 20px;
    text-shadow: rgba(110, 110, 110, 0.377) 5px 0 10px;
  }
  button#start-study-button > img.start-study-img {
    height: 300px;
    width: 300px;
  }
  div.home {
    background: rgb(240, 240, 240);
    height: 520px;
    box-shadow:
    0 2.8px 2.2px rgba(0, 0, 0, 0.034),
    0 6.7px 5.3px rgba(0, 0, 0, 0.048),
    0 6.5px 5px rgba(0, 0, 0, 0.06),
    0 12.3px 7.9px rgba(0, 0, 0, 0.072),
    0 41.8px 23.4px rgba(0, 0, 0, 0.086),
    0 50px 80px rgba(0, 0, 0, 0.12);
    border-radius: 10px;
  }
  div.home-buttons {
    display: flex;
    justify-content: space-evenly;
  }
  button#decks {
    display: flex;
    
  }
  div > h1 {
    color: #274e13ff;
  }
  div > p.subtitle {
    text-align: center;
    color: #274e13ff;
  }
  div.deck-list {
    color:  #274e13ff;
  }
  div.study-session-home {
    color:  #274e13ff;
  }
  button {
    border: none;
    background: none;
    cursor: pointer;
  }
</style>
