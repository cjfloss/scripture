namespace BibleNow.Entities {
    public class Verse {
        public int number;
        public string content;
        public bool paragraph_end;

        public Verse (int number, string content) {
            this.number = number;
            this.content = content;
        }
    }
}
