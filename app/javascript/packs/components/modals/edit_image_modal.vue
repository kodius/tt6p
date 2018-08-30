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
    <b-loading :is-full-page="false" :active.sync="isLoading" :can-cancel="false"></b-loading>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    props: ['originalImage', 'measurement', 'file'],
    data: function() {
      return {
        image: this.originalImage,
        isLoading: false
      }
    },
    mounted() {
      let $el = document.getElementById('image-holder');

      $el.src = this.originalImage;
    },
    methods: {
      uplaodImage() {
        let form_data = new FormData();
        var that = this;
        console.log(this.file);
        form_data.append('image', this.file, this.file.name);
        form_data.append('log_date', this.measurement.logDate);
        this.isLoading = true;

        axios.post('upload-image', form_data, {
          headers: {
            'Content-Type': `multipart/form-data; boundary=${this.file._boundary}`
          }
        }).then(response => {
          that.$parent.close();
          that.isLoading = false;
          that.$toast.open({
                      message: 'Image is uplaoded successfuly 💪🏻',
                      position: 'is-bottom',
                      type: 'is-success'
                  });
          that.$router.push({ name: 'dashboard_path' })
        });
      }
    }
  }
</script>