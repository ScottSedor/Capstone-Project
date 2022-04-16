<template>
  <div id="app">
    <div id="nav">
      <div id="site-title">
        <router-link id="title" v-bind:to="{ name: 'home' }">
          <img class="logo" src="..\src\assets\capture.jpg" alt="Stud.io Logo" />
        </router-link>
      </div>
      <div id="nav-buttons">
        <router-link class="btn" v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
        <router-link class="btn" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
      </div>
    </div>
    <div class="router-view">
      <router-view />
    </div>
  </div>
</template>

<style>
  /* @import url('https://fonts.googleapis.com/css2?family=Roboto+Mono'); */

  div#app {
    display: grid;
    grid-template-areas: 
      "nav nav nav nav"
      ". main main .";
    background-color: #d9ead3ff;
  }

  img {
    margin-top: 31px;
    width: 175px;
    height: 125px;
  }

  div#app {
    font-family: Arial, Helvetica, sans-serif;
  }

  div#nav {
    grid-area: nav;
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    border-bottom: 3px solid white;
    background-color: #b6d7a8ff;
  }

  div.router-view{
    grid-area: main;
    padding-left: 10vw;
    padding-right: 10vw;
    background-color: #d9ead3ff;
  }

  div#site-title {
    margin-left: 3vw;
  }

  div#site-title > #title {
    text-decoration: none;
    color: white;
  }

  div#nav-buttons {
    margin: 3vh 3vw 3vh 3vw;
    flex-flow: 1;
  }

  div#nav-buttons .btn {
    text-decoration: none;
    color: white;
    font-size: 1.65rem;
  }

  div#nav-buttons .btn:hover {
    color: #93c47dff;;
  }

  h1 {
    display: flex;
    justify-content: center;
    font-size: 40px;
  }
</style>