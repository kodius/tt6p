<template>
  <div class="modal-card">
    <header class="modal-card-head">
      <p class="modal-card-title">Change avatar</p>
    </header>
    <section class="modal-card-body">
      <div v-if="step === 0">
        <b-field>
          <b-upload v-model="dropFiles"
            drag-drop
            @input="imageSelected">
            <section class="section">
              <div class="content has-text-centered">
                <p>
                  <b-icon
                    icon="upload"
                    size="is-large">
                  </b-icon>
                </p>
                <p>Drop your profile pictrue here or click to upload</p>
              </div>
            </section>
          </b-upload>
        </b-field>
      </div>
      <div v-if="step === 1">
        <img id="" :src="imageSrc" alt="New profile image">
      </div>
      <b-loading :is-full-page="false" :active.sync="isLoading" :can-cancel="false"></b-loading>
    </section>
    <footer class="modal-card-foot">
      <button v-if="step === 1" class="button is-primary" @click="uplaodImage" >Upload</button>
      <button class="button" @click="$parent.close()">{{ $t('cancel')}}</button>
    </footer>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        dropFiles: [],
        step: 0,
        imageSrc: null,
        isLoading: false,
        file: null
      }
    },
    methods: {
      imageSelected() {
        this.file    = this.dropFiles[0] //sames as here
        var reader  = new FileReader();
        var that = this;

        reader.onloadend = function () {
          that.imageSrc = reader.result;
          that.step = 1;
        }

        if (this.file) {
          reader.readAsDataURL(this.file); //reads the data as a URL
        } else {
          this.imageSrc = null;
        }
      },

      uplaodImage() {
        let form_data = new FormData();
        var that = this;
        form_data.append('image', this.file, this.file.name);
        this.isLoading = true;

        axios.post('change-avatar', form_data, {
          headers: {
            'Content-Type': `multipart/form-data; boundary=${this.file._boundary}`
          }
        }).then(response => {
          that.$parent.close();
          that.isLoading = false;
          that.$toast.open({
                      message: 'Avatar is uplaoded successfuly 💪🏻',
                      position: 'is-bottom',
                      type: 'is-success'
                  });
                  console.warn(that.$parent);
                  
          that.$parent._data.user.avatar.url = response.newAvatar;
        });
      }
    }
  }
</script>