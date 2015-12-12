import core.thread;
import std.stdio;
import std.string;

const int SCREEN_WIDTH = 80;

void cls()
{
	write("\x1b[2J");
}

void locate(int x, int y)
{
	writef("\033[%d;%dH" ,y, x);
}

void dman(int frame, int offset)
{
	string aa = data[frame];
	foreach (int idx, line; aa.splitLines) {
		if (offset + cast(int)line.length > SCREEN_WIDTH) {
			if (offset < SCREEN_WIDTH) {
				locate(offset, idx + 2);
				write(line[0 .. SCREEN_WIDTH - offset]);
			}
		} else if (offset >= 0) {
			locate(offset, idx + 2);
			write(line);
		} else {
			if (offset + cast(int)line.length > 0) {
				locate(0, idx + 2);
				write(line[-offset .. $]);
			}
		}
	}
	stdout.flush();
}

void main()
{
	for (int i = 0; i < SCREEN_WIDTH + 20; i++) {
		cls();
		dman(i / 6 % 4, SCREEN_WIDTH + 10 - i);
		Thread.sleep(20.msecs);
	}
	locate(0, 0);
}

const string[] data = [`
  _   _
 (_) (_)
/______ \
\\(O(O \/
 | | | |
 | |_| |
/______/
  <   >
 (_) (_)
`,`
  _   _
 (_) (_)
/______ \
\\(O(O \/
 | | | |
 | |_| |
/______/
 (_)  >
     (_)
`,`
  _   _
 (_) (_)
/______ \
\\(O(O \/
 | | | |
 | |_| |
/______/
  <   >
 (_) (_)
`,`
  _   _
 (_) (_)
/______ \
\\(O(O \/
 | | | |
 | |_| |
/______/
  <  (_)
 (_) 
`];
