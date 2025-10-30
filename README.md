# Vue Prime Vue Template

Aplicação de configurações desenvolvida com Vue 3, PrimeVue e Tailwind seguindo os requisitos propostos. A interface reproduz o comportamento de menus de apps modernos, possui rotas dedicadas para cada subseção, modo claro/escuro persistido e integração com TanStack Query e Storybook.

## ✨ Principais recursos

- Layout responsivo com menu lateral agrupado e comportamento especial para mobile.
- Rotas `/settings` e `/settings/:submenu` com Vue Router.
- Conteúdos específicos para Perfil, Segurança, Privacidade, Notificações e Aparência utilizando componentes PrimeVue.
- Tema claro/escuro com persistência em `localStorage` e troca dinâmica do tema PrimeVue.
- Dialog de confirmação de logout usando `DynamicDialog`.
- Consulta simulada de perfil com TanStack Query e reuso dos dados em diferentes partes da UI.
- Storybook configurado com três componentes documentados (`ThemeToggle`, `SettingsHeader`, `SettingsSidebar`).
- Tailwind CSS integrado ao PrimeVue para estilização utilitária.

## 🛠️ Stack utilizada

- [Vue 3](https://vuejs.org/) + [Vite](https://vite.dev/)
- [TypeScript](https://www.typescriptlang.org/)
- [PrimeVue](https://www.primefaces.org/primevue/) e PrimeIcons
- [Tailwind CSS](https://tailwindcss.com/)
- [TanStack Query](https://tanstack.com/query/latest)
- [Storybook 10](https://storybook.js.org/)

## 🚀 Como executar

1. Instale as dependências:

   ```bash
   npm install
   ```

2. Rode o servidor de desenvolvimento:

   ```bash
   npm run dev
   ```

   O projeto ficará disponível em [http://localhost:5173](http://localhost:5173).

3. Execute o Storybook (opcional):

   ```bash
   npm run storybook
   ```

   A documentação interativa abre em [http://localhost:6006](http://localhost:6006).

4. Para gerar o build de produção:

   ```bash
   npm run build
   ```

   Depois visualize o resultado com:

   ```bash
   npm run preview
   ```

### ▶️ Executar com Docker

Também é possível subir o ambiente de desenvolvimento sem precisar instalar o Node localmente. Certifique-se de ter o [Docker](https://docs.docker.com/get-docker/) e o [Docker Compose](https://docs.docker.com/compose/) instalados e então execute:

```bash
docker compose up --build
```

O comando acima monta os arquivos do projeto dentro do container, instala as dependências automaticamente e inicia o Vite em modo desenvolvimento exposto na porta `5173`. Ao finalizar, derrube o serviço com `Ctrl+C`. Para executar em segundo plano, utilize `docker compose up -d` e finalize com `docker compose down`.

## 🗂️ Estrutura de pastas

```
src/
├── assets/            # Estilos globais (Tailwind + ajustes PrimeVue)
├── components/        # Componentes de interface reutilizáveis
├── composables/       # Hooks reativos (tema, queries, media query)
├── data/              # Definições do menu de configurações
├── router/            # Configuração do Vue Router
└── views/             # Páginas e seções da área de configurações
```

As histórias do Storybook vivem próximas aos componentes (`*.stories.ts`).

## 🧭 Navegação e comportamento

- Em telas grandes o menu lateral permanece visível enquanto o conteúdo muda conforme a rota.
- Em mobile, `/settings` mostra apenas o menu e `/settings/:submenu` exibe somente o conteúdo com botão de voltar.
- O tema selecionado (claro ou escuro) é reaplicado automaticamente na próxima visita.
- O botão "Sair" abre um `DynamicDialog` de confirmação; a confirmação é tratada com um log (mockado).

## 📦 Scripts disponíveis

| Comando               | Descrição                                      |
| --------------------- | ---------------------------------------------- |
| `npm run dev`         | Inicia o Vite em modo desenvolvimento          |
| `npm run build`       | Gera build de produção                         |
| `npm run preview`     | Visualiza o build gerado                       |
| `npm run lint`        | Checa os tipos com `vue-tsc`                   |
| `npm run storybook`   | Abre o Storybook com a documentação de UI      |
| `npm run build-storybook` | Gera a versão estática do Storybook       |

## 📄 Guia de deploy

Consulte o arquivo [`VERCEL_DEPLOY.md`](./VERCEL_DEPLOY.md) para o passo a passo de publicação na Vercel.

---

Feito com ❤️ usando Vue, PrimeVue e Tailwind.
