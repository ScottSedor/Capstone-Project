<template>
  <div id="app">
    <div id="nav">
      <div id="site-title">
        <router-link id="title" v-bind:to="{ name: 'home' }">
          <h1>Flash Card Study App</h1>
        </router-link>
      </div>
      <div id="nav-buttons">
        <router-link class="btn" v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
        <router-link class="btn" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
      </div>
    </div>
    <router-view />
  </div>
</template>

<style>
  /* @import url('https://fonts.googleapis.com/css2?family=Roboto+Mono'); */

  div#app {
    font-family: Arial, Helvetica, sans-serif;
  }

  div#nav {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    border-bottom: 3px solid black;
  }

  div#site-title {
    margin-left: 3vw;
  }

  div#site-title > #title {
    text-decoration: none;
    color: black;
  }

  div#nav-buttons {
    margin: 3vh 3vw 3vh 3vw;
    flex-flow: 1;
  }

  div#nav-buttons .btn {
    text-decoration: none;
    color: black;
    font-size: 1.35rem;
  }

  div#nav-buttons .btn:hover {
    color: gray;
  }

  h1 {
    display: flex;
    justify-content: center;
    font-size: 40px;
  }
</style>