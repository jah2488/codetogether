import Filter from "bad-words";

const wordWhitelist = ["hell"];

export default class _Filter {
  filter:Filter 
  constructor() {
    this.filter = new Filter();
    this.filter.removeWords(...wordWhitelist);
  }

  isProfane(word: string): boolean {
    return this.filter.isProfane(word);
  }
}
