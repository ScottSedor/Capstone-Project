<template>
  <div id="app">
    <div id="nav">
      <div id="site-title">
        <router-link id="title" v-bind:to="{ name: 'home' }">
          <img class="logo" src="..\src\assets\capture.jpg" alt="Stud.io Logo" />
        </router-link>
      </div>
      <div id="nav-buttons">
        <div id="home">
          <router-link class="btn" v-bind:to="{ name: 'home' }">Home</router-link>
        </div>
        <div id="logout">
          <router-link class="btn" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
        </div>
      </div>
    </div>
    <div class="router-view">
      <router-view />
    </div>
  </div>
</template>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Roboto+Mono');

  body {
    background-color: #d9ead3ff;
  }

  div#app {
    background-color: #d9ead3ff;
  
  }

  img.logo {
    /* margin-top: 32px; */
    width: 190px;
    height: 120px;
  }

  img.logo:hover {
    transform: scale(1.01);
  }

  div#app {
    font-family: 'Roboto Mono', monospace;
  }

  div#nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 3px solid #274e13ff;
    background-color: #b6d7a8ff;
  }

  div.router-view{
    padding-left: 10vw;
    padding-right: 10vw;
    background-color: #d9ead3ff;
  }

  div#site-title {
    margin: 2.5vw;
  }

  div#nav-buttons {
    margin: 3vh 3vw 3vh 3vw;
    flex-flow: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

  div#nav-buttons .btn {
    text-decoration: none;
    color: #d9ead3ff;
    font-size: 1.65rem;
  }

  div#nav-buttons .btn:hover {
    color: #93c47dff;
  }

  h1 {
    display: flex;
    justify-content: center;
    font-size: 40px;
  }

  div#home {
    border-bottom: 2px solid #d9ead3ff;
  }
</style>