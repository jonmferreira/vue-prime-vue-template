<template>
  <div class="space-y-6">
    <Card>
      <template #title>
        <div class="flex items-center justify-between gap-3">
          <span>Bem-vindo às suas configurações</span>
          <Tag value="Resumo" severity="info" />
        </div>
      </template>
      <template #content>
        <p class="text-sm leading-relaxed text-slate-600 dark:text-slate-300">
          Revise os principais controles da conta e personalize cada detalhe conforme a sua rotina. Utilize o menu ao lado
          para acessar áreas específicas como privacidade, notificações e aparência.
        </p>
      </template>
    </Card>

    <div class="grid gap-4 md:grid-cols-2">
      <Card>
        <template #title>Atalhos rápidos</template>
        <template #content>
          <div class="flex flex-col gap-3">
            <Button label="Editar perfil" icon="pi pi-user-edit" @click="goTo('perfil')" outlined />
            <Button label="Ajustar segurança" icon="pi pi-shield" @click="goTo('seguranca')" outlined />
            <Button label="Preferências de notificações" icon="pi pi-bell" @click="goTo('notificacoes')" outlined />
          </div>
        </template>
      </Card>

      <Card>
        <template #title>Status da conta</template>
        <template #content>
          <ul class="space-y-3 text-sm text-slate-600 dark:text-slate-300">
            <li class="flex items-center gap-2">
              <i class="pi pi-lock text-emerald-500"></i>
              Autenticação em duas etapas ativa
            </li>
            <li class="flex items-center gap-2">
              <i class="pi pi-envelope text-emerald-500"></i>
              E-mail principal verificado
            </li>
            <li class="flex items-center gap-2">
              <i class="pi pi-mobile text-emerald-500"></i>
              Notificações push habilitadas no aplicativo
            </li>
          </ul>
        </template>
      </Card>
    </div>
  </div>
</template>

<script setup lang="ts">
import Button from 'primevue/button';
import Card from 'primevue/card';
import Tag from 'primevue/tag';
import { useRouter } from 'vue-router';

const router = useRouter();

const goTo = (section: string) => {
  router.push({ name: 'settings-section', params: { section } });
};
</script>
