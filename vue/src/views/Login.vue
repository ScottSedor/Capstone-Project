<template>
  <div id="login" class="text-center">
    <form class="form-signin" @submit.prevent="login">
      
      <div
        class="alert alert-danger"
        role="alert"
        v-if="invalidCredentials"
      >Invalid username and password!</div>
      <div
        class="alert alert-success"
        role="alert"
        v-if="this.$route.query.registration"
      >Thank you for registering, please sign in.
      </div>

      <div class="login-fields">
      <h1 class="h3 mb-3 font-weight-normal">Please Sign In</h1>
      <label for="username" class="sr-only">Username</label>
      <input
        type="text"
        id="username"
        class="form-control"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <label for="password" class="sr-only">Password</label>
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <button class="submit" type="submit">Sign in</button>
      <router-link :to="{ name: 'register' }">Need an account?</router-link>
      </div>

      <div id="before">
      <p>Before Stud.io</p>
      <img class="angry-img" src="..\assets\angry-learner.png" alt="frustrated child studying">
      </div>

      <div id="after">
      <p>One Week Of Stud.io</p>
      <img class="happy-img" src="..\assets\happy-learner.png" alt="happy woman learning">
      </div>

    </form>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "login",
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$router.push("/");
          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    }
  }
};
</script>

<style>

div#before > p, div#after > p {
  text-align: center;
}

div#before {
  margin-left: 10px;
  display: flex;
  flex-direction: column;
}
div#after {
  margin-left: 50px;
  display: flex;
  flex-direction: column;
}
div.login-fields {
  display: flex;
  flex-direction: column;
  margin: 20px;
  margin-right: 285px;
}
img.angry-img {
  height: 280px;
  width: 280px;
}
img.happy-img {
  height: 280px;
  width: 420px
}
form.form-signin {
  display: flex;
  height: 350px;
  background: rgb(240, 240, 240);
  margin-top: 30px;
  box-shadow:
  0 2.8px 2.2px rgba(0, 0, 0, 0.034),
  0 6.7px 5.3px rgba(0, 0, 0, 0.048),
  0 6.5px 5px rgba(0, 0, 0, 0.06),
  0 12.3px 7.9px rgba(0, 0, 0, 0.072),
  0 41.8px 23.4px rgba(0, 0, 0, 0.086),
  0 50px 80px rgba(0, 0, 0, 0.12);
  border-radius: 5px;
}
form.form-register {
  background: rgb(240, 240, 240);
}
button.submit {
  margin-top: 10px;
  margin-bottom: 10px;
  background: rgb(221, 221, 221);
  border: solid 1px black;
  border-radius: 5px;
}
button.submit:hover {
  background: rgb(238, 238, 238);
  border: solid 1px black;
  border-radius: 5px;
}
label.sr-only {
  color: #274e13ff;
}

</style>