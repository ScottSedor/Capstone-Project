<template>
  <card-info />
</template>

<script>
import CardInfo from '@/components/CardInfo.vue'

export default {
  components: { 
        CardInfo 
  },
created() {
    const cardId = this.$route.params.cardId;
    this.$store.commit('SET_ACTIVE_CARD', cardId);
}

}
</script>

<style>

</style>