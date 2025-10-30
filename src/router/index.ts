import { createRouter, createWebHistory } from 'vue-router';

import SettingsLayout from '@/views/settings/SettingsLayout.vue';
import SettingsOverview from '@/views/settings/SettingsOverview.vue';
import SettingsSectionView from '@/views/settings/SettingsSectionView.vue';
import { DEFAULT_SECTION, isValidSection } from '@/data/settings-menu';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: '/settings'
    },
    {
      path: '/settings',
      component: SettingsLayout,
      children: [
        {
          path: '',
          name: 'settings-home',
          component: SettingsOverview
        },
        {
          path: ':section',
          name: 'settings-section',
          component: SettingsSectionView,
          props: (route) => ({ sectionId: route.params.section as string })
        }
      ]
    },
    {
      path: '/:pathMatch(.*)*',
      redirect: '/settings'
    }
  ]
});

router.beforeEach((to) => {
  if (to.name === 'settings-section' && !isValidSection(to.params.section as string | undefined)) {
    return { name: 'settings-section', params: { section: DEFAULT_SECTION } };
  }

  return true;
});

export default router;
