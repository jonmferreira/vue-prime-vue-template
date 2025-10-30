<template>
  <component :is="sectionComponent" />
</template>

<script setup lang="ts">
import { computed } from 'vue';

import AppearanceSettingsView from './sections/AppearanceSettingsView.vue';
import NotificationsSettingsView from './sections/NotificationsSettingsView.vue';
import PermissionsSettingsView from './sections/PermissionsSettingsView.vue';
import ProfileSettingsView from './sections/ProfileSettingsView.vue';
import SecuritySettingsView from './sections/SecuritySettingsView.vue';

const props = defineProps<{
  sectionId: string;
}>();

const sectionComponent = computed(() => {
  const mapping: Record<string, object> = {
    perfil: ProfileSettingsView,
    seguranca: SecuritySettingsView,
    permissoes: PermissionsSettingsView,
    notificacoes: NotificationsSettingsView,
    aparencia: AppearanceSettingsView
  };

  return mapping[props.sectionId] ?? ProfileSettingsView;
});
</script>
