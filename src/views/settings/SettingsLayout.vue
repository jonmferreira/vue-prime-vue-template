<template>
  <div class="min-h-screen bg-slate-100/70 dark:bg-slate-950">
    <SettingsHeader
      :title="headerTitle"
      :subtitle="headerSubtitle"
      :show-back="showBackButton"
      :is-dark="isDark"
      @back="navigateToMenu"
      @toggle-theme="handleThemeToggle"
    >
      <template #actions>
        <Button icon="pi pi-question-circle" label="Central de ajuda" severity="secondary" text class="hidden md:flex" />
      </template>
    </SettingsHeader>

    <main class="mx-auto flex w-full max-w-6xl flex-col gap-6 px-4 py-6 lg:flex-row lg:px-6">
      <section v-if="showMenu" class="lg:w-80">
        <SettingsSidebar
          :groups="menuGroups"
          :active-id="activeSectionId"
          :name="sidebarName"
          :email="sidebarEmail"
          @select="handleSelect"
          @logout="openLogoutDialog"
        />
      </section>

      <section v-if="showContent" class="flex-1">
        <RouterView v-slot="{ Component }">
          <Transition name="fade" mode="out-in">
            <component :is="Component" :key="$route.fullPath" />
          </Transition>
        </RouterView>
      </section>
    </main>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import Button from 'primevue/button';
import { useDialog } from 'primevue/usedialog';
import { useRoute, useRouter } from 'vue-router';

import SettingsHeader from '@/components/settings/SettingsHeader.vue';
import SettingsSidebar from '@/components/settings/SettingsSidebar.vue';
import LogoutConfirmationDialog from '@/components/settings/LogoutConfirmationDialog.vue';
import { settingsMenuGroups, findMenuItemById } from '@/data/settings-menu';
import { useMediaQuery } from '@/composables/useMediaQuery';
import { useTheme } from '@/composables/useTheme';
import { useProfileSettings } from '@/composables/useProfileSettings';

const route = useRoute();
const router = useRouter();
const dialog = useDialog();
const isDesktop = useMediaQuery('(min-width: 1024px)');
const { isDark, setTheme } = useTheme();
const profileQuery = useProfileSettings();

const menuGroups = settingsMenuGroups;

const activeSectionId = computed(() => (route.params.section as string | undefined) ?? null);
const activeItem = computed(() => findMenuItemById(activeSectionId.value ?? undefined));

const showBackButton = computed(() => !isDesktop.value && route.name === 'settings-section');
const showMenu = computed(() => isDesktop.value || route.name !== 'settings-section');
const showContent = computed(() => isDesktop.value || route.name === 'settings-section');

const headerTitle = computed(() => activeItem.value?.label ?? 'Configurações');
const headerSubtitle = computed(
  () => activeItem.value?.description ?? 'Centralize suas preferências e personalize a experiência do aplicativo.'
);

const sidebarName = computed(() => profileQuery.data.value?.name ?? 'Carregando...');
const sidebarEmail = computed(() => profileQuery.data.value?.email ?? '');

const handleSelect = (id: string) => {
  router.push({ name: 'settings-section', params: { section: id } });
};

const navigateToMenu = () => {
  router.push({ name: 'settings-home' });
};

const handleThemeToggle = (value: boolean) => {
  setTheme(value ? 'dark' : 'light');
};

const openLogoutDialog = () => {
  dialog.open(LogoutConfirmationDialog, {
    props: {
      header: 'Deseja sair?',
      modal: true,
      style: { width: '28rem' }
    },
    onClose: (event) => {
      if (event?.data?.confirmed) {
        console.info('Usuário realizou logout.');
      }
    }
  });
};
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
