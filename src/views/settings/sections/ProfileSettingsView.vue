<template>
  <Card>
    <template #title>Informações pessoais</template>
    <template #content>
      <div v-if="isLoading" class="space-y-4">
        <Skeleton height="2rem" class="rounded-lg" />
        <Skeleton height="2rem" class="rounded-lg" />
        <Skeleton height="6rem" class="rounded-lg" />
      </div>
      <form v-else class="space-y-6" @submit.prevent="onSubmit">
        <div class="grid gap-4 md:grid-cols-2">
          <span class="p-float-label">
            <InputText id="name" v-model="form.name" class="w-full" />
            <label for="name">Nome completo</label>
          </span>
          <span class="p-float-label">
            <InputText id="username" v-model="form.username" class="w-full" />
            <label for="username">Nome de usuário</label>
          </span>
          <span class="p-float-label">
            <InputText id="email" v-model="form.email" class="w-full" type="email" />
            <label for="email">E-mail</label>
          </span>
          <span class="p-float-label">
            <InputText id="phone" v-model="form.phone" class="w-full" />
            <label for="phone">Telefone</label>
          </span>
          <span class="p-float-label">
            <Calendar id="birthday" v-model="formBirthday" showIcon dateFormat="dd/mm/yy" class="w-full" />
            <label for="birthday">Data de nascimento</label>
          </span>
          <span class="p-float-label">
            <Dropdown id="language" v-model="form.language" :options="languageOptions" option-label="label" option-value="value" class="w-full" />
            <label for="language">Idioma</label>
          </span>
        </div>
        <span class="p-float-label">
          <Textarea id="bio" v-model="form.bio" auto-resize rows="4" class="w-full" />
          <label for="bio">Biografia</label>
        </span>
        <span class="p-float-label">
          <InputText id="location" v-model="form.location" class="w-full" />
          <label for="location">Localização</label>
        </span>
        <div class="flex justify-end gap-3">
          <Button type="button" label="Descartar" severity="secondary" text @click="resetForm" />
          <Button type="submit" label="Salvar alterações" icon="pi pi-check" />
        </div>
      </form>
    </template>
  </Card>
</template>

<script setup lang="ts">
import { computed, reactive, watch } from 'vue';
import Button from 'primevue/button';
import Calendar from 'primevue/calendar';
import Card from 'primevue/card';
import Dropdown from 'primevue/dropdown';
import InputText from 'primevue/inputtext';
import Skeleton from 'primevue/skeleton';
import Textarea from 'primevue/textarea';

import { useProfileSettings } from '@/composables/useProfileSettings';

const profileQuery = useProfileSettings();

const form = reactive({
  name: '',
  username: '',
  email: '',
  phone: '',
  bio: '',
  location: '',
  birthday: new Date(),
  language: 'pt-BR'
});

const languageOptions = [
  { label: 'Português (Brasil)', value: 'pt-BR' },
  { label: 'Inglês (Estados Unidos)', value: 'en-US' },
  { label: 'Espanhol (LatAm)', value: 'es-419' }
];

const isLoading = computed(() => profileQuery.isLoading.value);

const formBirthday = computed({
  get: () => form.birthday,
  set: (value: Date | null) => {
    form.birthday = value ?? form.birthday;
  }
});

watch(
  () => profileQuery.data.value,
  (profile) => {
    if (!profile) {
      return;
    }

    form.name = profile.name;
    form.username = profile.username;
    form.email = profile.email;
    form.phone = profile.phone;
    form.bio = profile.bio;
    form.location = profile.location;
    form.language = profile.language;
    form.birthday = new Date(profile.birthday);
  },
  { immediate: true }
);

const resetForm = () => {
  const profile = profileQuery.data.value;
  if (!profile) {
    return;
  }

  form.name = profile.name;
  form.username = profile.username;
  form.email = profile.email;
  form.phone = profile.phone;
  form.bio = profile.bio;
  form.location = profile.location;
  form.language = profile.language;
  form.birthday = new Date(profile.birthday);
};

const onSubmit = () => {
  console.info('Perfil atualizado', { ...form });
};
</script>
