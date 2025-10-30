<template>
  <div class="space-y-5">
    <Card>
      <template #title>Autenticação</template>
      <template #content>
        <div class="space-y-4">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="font-medium text-slate-700 dark:text-slate-100">Autenticação em duas etapas</p>
              <p class="text-sm text-slate-500 dark:text-slate-400">Solicitar código adicional ao acessar um novo dispositivo.</p>
            </div>
            <InputSwitch v-model="twoFactor" aria-label="Ativar autenticação em duas etapas" />
          </div>
          <Divider />
          <div class="space-y-3">
            <label class="text-sm font-semibold text-slate-600 dark:text-slate-300" for="password">Atualizar senha</label>
            <Password
              id="password"
              v-model="password"
              toggleMask
              promptLabel="Digite uma senha segura"
              weakLabel="Fraca"
              mediumLabel="Média"
              strongLabel="Forte"
              class="w-full md:w-2/3"
            />
            <div class="flex justify-end">
              <Button label="Salvar senha" icon="pi pi-shield" :disabled="!password" />
            </div>
          </div>
        </div>
      </template>
    </Card>

    <Card>
      <template #title>Dispositivos conectados</template>
      <template #content>
        <DataTable :value="devices" size="small" responsive-layout="scroll">
          <Column field="name" header="Dispositivo"></Column>
          <Column field="location" header="Localização"></Column>
          <Column field="lastAccess" header="Último acesso"></Column>
          <Column header="Ação">
            <template #body>
              <Button label="Remover" text severity="danger" size="small" icon="pi pi-times" />
            </template>
          </Column>
        </DataTable>
      </template>
    </Card>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import Button from 'primevue/button';
import Card from 'primevue/card';
import Column from 'primevue/column';
import DataTable from 'primevue/datatable';
import Divider from 'primevue/divider';
import InputSwitch from 'primevue/inputswitch';
import Password from 'primevue/password';

const twoFactor = ref(true);
const password = ref('');

const devices = [
  { name: 'iPhone 15 Pro', location: 'Chapecó, Brasil', lastAccess: 'Há 2 horas' },
  { name: 'MacBook Air', location: 'Florianópolis, Brasil', lastAccess: 'Ontem' },
  { name: 'Web App', location: 'São Paulo, Brasil', lastAccess: 'Há 3 dias' }
];
</script>
