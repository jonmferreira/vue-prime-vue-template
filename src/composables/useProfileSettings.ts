import { useQuery } from '@tanstack/vue-query';

export interface ProfileSettings {
  id: string;
  name: string;
  username: string;
  email: string;
  phone: string;
  bio: string;
  location: string;
  birthday: string;
  language: string;
}

const PROFILE_QUERY_KEY = ['profile-settings'];

async function fetchProfile(): Promise<ProfileSettings> {
  await new Promise((resolve) => setTimeout(resolve, 600));

  return {
    id: 'user-1',
    name: 'Maria Eduarda',
    username: 'mariaeduarda',
    email: 'maria@example.com',
    phone: '+55 49 98888-2211',
    bio: 'Product designer apaixonada por criar experiências simples e humanas.',
    location: 'Florianópolis, Brasil',
    birthday: '1994-08-19',
    language: 'pt-BR'
  };
}

export function useProfileSettings() {
  return useQuery({
    queryKey: PROFILE_QUERY_KEY,
    queryFn: fetchProfile,
    staleTime: 1000 * 60 * 5
  });
}
