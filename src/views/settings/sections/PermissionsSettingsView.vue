<template>
  <div class="space-y-5">
    <Card>
      <template #title>Privacidade do perfil</template>
      <template #content>
        <div class="space-y-3 text-sm text-slate-600 dark:text-slate-300">
          <div class="flex items-start gap-3">
            <Checkbox v-model="showStatus" inputId="status" binary />
            <div>
              <label for="status" class="font-semibold text-slate-700 dark:text-slate-200">Exibir status online</label>
              <p class="text-xs text-slate-500 dark:text-slate-400">Permite que seus contatos saibam quando você está ativo.</p>
            </div>
          </div>
          <div class="flex items-start gap-3">
            <Checkbox v-model="shareActivity" inputId="activity" binary />
            <div>
              <label for="activity" class="font-semibold text-slate-700 dark:text-slate-200">Compartilhar atividade</label>
              <p class="text-xs text-slate-500 dark:text-slate-400">Mostra atualizações de curtidas, comentários e novos seguidores.</p>
            </div>
          </div>
          <div class="flex items-start gap-3">
            <Checkbox v-model="allowMessages" inputId="messages" binary />
            <div>
              <label for="messages" class="font-semibold text-slate-700 dark:text-slate-200">Receber mensagens de desconhecidos</label>
              <p class="text-xs text-slate-500 dark:text-slate-400">Mensagens desconhecidas irão para a caixa de solicitações.</p>
            </div>
          </div>
        </div>
      </template>
    </Card>

    <Card>
      <template #title>Dados compartilhados</template>
      <template #content>
        <Fieldset legend="Integrações externas" toggleable :collapsed="false">
          <div class="space-y-2 text-sm text-slate-600 dark:text-slate-300">
            <div class="flex items-center justify-between">
              <span>Google Calendar</span>
              <Button label="Revogar" text severity="danger" />
            </div>
            <div class="flex items-center justify-between">
              <span>Notion</span>
              <Button label="Gerenciar" text />
            </div>
            <div class="flex items-center justify-between">
              <span>Slack</span>
              <Button label="Revogar" text severity="danger" />
            </div>
          </div>
        </Fieldset>
      </template>
    </Card>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import Button from 'primevue/button';
import Card from 'primevue/card';
import Checkbox from 'primevue/checkbox';
import Fieldset from 'primevue/fieldset';

const showStatus = ref(true);
const shareActivity = ref(false);
const allowMessages = ref(false);
</script>
