export interface SettingsMenuItem {
  id: string;
  label: string;
  description: string;
  icon: string;
}

export interface SettingsMenuGroup {
  id: string;
  label: string;
  items: SettingsMenuItem[];
}

export const DEFAULT_SECTION = 'perfil';

export const settingsMenuGroups: SettingsMenuGroup[] = [
  {
    id: 'conta',
    label: 'Conta',
    items: [
      {
        id: 'perfil',
        label: 'Perfil',
        description: 'Informações pessoais e dados públicos',
        icon: 'pi pi-user'
      },
      {
        id: 'seguranca',
        label: 'Segurança',
        description: 'Autenticação e atividade recente',
        icon: 'pi pi-shield'
      }
    ]
  },
  {
    id: 'privacidade',
    label: 'Privacidade',
    items: [
      {
        id: 'permissoes',
        label: 'Permissões',
        description: 'Controle quem vê seus dados e atividade',
        icon: 'pi pi-lock'
      }
    ]
  },
  {
    id: 'preferencias',
    label: 'Preferências',
    items: [
      {
        id: 'notificacoes',
        label: 'Notificações',
        description: 'Gerencie alertas push e e-mails',
        icon: 'pi pi-bell'
      },
      {
        id: 'aparencia',
        label: 'Aparência',
        description: 'Tema, densidade e personalização da interface',
        icon: 'pi pi-palette'
      }
    ]
  }
];

export function findMenuItemById(id?: string | null): SettingsMenuItem | undefined {
  if (!id) {
    return undefined;
  }

  return settingsMenuGroups.flatMap((group) => group.items).find((item) => item.id === id);
}

export function isValidSection(id?: string | null): id is string {
  return Boolean(findMenuItemById(id));
}
