<template>
  <div class="modal-card">
    <header class="modal-card-head">
      <p class="modal-card-title">Are you sure you want to upload this image?</p>
    </header>
    <section class="modal-card-body">
      <figure><img id="image-holder" style="max-height: 400px" /></figure>
    </section>
    <footer class="modal-card-foot">
      <button class="button is-primary" @click="uplaodImage" >Upload</button>
      <button class="button" @click="$parent.close()">{{ $t('cancel')}}</button>
    </footer>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    props: ['originalImage'],
    data: function() {
      return {
        image: this.originalImage
      }
    },
    mounted() {
      let $el = document.getElementById('image-holder');

      $el.src = this.originalImage;
    },
    methods: {
      uplaodImage() {
        
      }
    }
  }
</script>