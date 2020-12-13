interface Nominee {
  body: string;
  id: number;
  vote_count: number;
}

interface Game {
  can_vote: boolean;
  code: string;
  complete: boolean;
  confetti: boolean;
  description: string;
  id: number;
  inserted_at: Date;
  max_input: number;
  messages: Message[];
  mode: string;
  name: string;
  nominees: Nominee[];
  output: { raw: string; err_ln: number };
  play_state: string;
  updated_at: Date;
  vote_interval: number;
  vote_threshold: number;
}

export type Message = {
  id: number;
  name: string;
  color: string;
  is_code: boolean;
  user_id: number;
};
export type { Game };
