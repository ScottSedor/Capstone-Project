<template>
  <div>
    <card-info />
    <div class="editButton">
      <button v-on:click="isEditing = !isEditing">Edit Card</button>
    </div>
    <div class="card-edit-form" v-show="isEditing == true">
      <card-form />
    </div>
  </div>
</template>

<script>
import CardInfo from '@/components/CardInfo.vue'
import CardForm from '@/components/CardForm.vue'

export default {
  components: { 
        CardInfo,
        CardForm 
  },
  data() {
    return {
      isEditing: false
    }
  },
  created() {
      const cardId = this.$route.params.cardId;
      this.$store.commit('SET_ACTIVE_CARD', cardId);
  }

}
</script>

<style>

</style>