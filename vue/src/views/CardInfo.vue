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
    const activeCardId = this.$route.params.cardId;
    this.$store.commit('SET_ACTIVE_CARD', activeCardId);
}

}
</script>

<style>

</style>