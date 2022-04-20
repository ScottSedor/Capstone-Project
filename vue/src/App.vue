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
    background-color: white;
  }

  img.logo {
    width: 135px;
    height: 90px;
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
    border-bottom: 4px solid #274e13ff;
    -webkit-box-shadow: 0px 15px 6px -6px rgba(119, 119, 119, 0.534);
    background-color: #b6d7a8ff;
    width: 100vw;
    border-radius: 30px;
    margin-bottom: 50px;
  }

  div.router-view{
    padding-left: 10vw;
    padding-right: 10vw;
  }

  div#site-title {
    margin: 1.5vw;
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
    color: white;
    font-size: 1.75rem;
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