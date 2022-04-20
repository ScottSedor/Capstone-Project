<template>
  <div id="register" class="text-center">
    <form class="form-register" @submit.prevent="register">


      <div class="register-fields">
      <h1 class="h3 mb-3 font-weight-normal">Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
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
      <input
        type="password"
        id="confirmPassword"
        class="form-control"
        placeholder="Confirm Password"
        v-model="user.confirmPassword"
        required
      />
      <button class="btn btn-lg btn-primary btn-block" type="submit">Create Account</button>
      <router-link :to="{ name: 'login' }">Have an account?</router-link>
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
import authService from '../services/AuthService';

export default {
  name: 'register',
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: 'user',
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Password & Confirm Password do not match.';
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: '/login',
                query: { registration: 'success' },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
  },
};
</script>

<style>

input.form-control {
  margin-top: 5px;
  margin-bottom: 5px;
}
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
div.register-fields {
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
form.form-register {
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
}
</style>
