package main

import (
    "fmt"
    "flag"
    "os"
    "strconv"
    "bufio"
)

func main() {
    head_n := flag.Int("head", 10, "number of first lines to display")
    tail_n := flag.Int("tail", 10, "number of last lines to display")
    quiet  := flag.Bool("quiet", false, "do not print anything else")

    version := flag.Bool("version", false, "print version number")

    flag.Parse()

    if *version {
        fmt.Println("1.0.0")
        return
    }

    r := bufio.NewReader(os.Stdin)
    w := bufio.NewWriter(os.Stdout)

    head_lines := 0
    tail_lines := make([]string, *tail_n)

    i := 0
    tail_read := 0
    for {
        line, err := r.ReadString('\n')
        if head_lines < *head_n {
            w.WriteString(line)
            head_lines++
        } else {
            if len(line) > 0 {
                tail_lines[i] = line
                i = (i + 1) % *tail_n
                tail_read++
            }
        }
        if err != nil {
            break
        }
    }

    if tail_read <= *tail_n {
        for i = 0; i < tail_read; i++ {
            w.WriteString(tail_lines[i])
        }
    } else {
        if !*quiet {
            w.WriteString("[.." + strconv.Itoa(tail_read - *tail_n) + " more lines..]\n")
        }
        for i = (tail_read) % *tail_n; i < *tail_n; i++ {
            w.WriteString(tail_lines[i])
        }
        for i = 0; i < (tail_read) % *tail_n; i++ {
            w.WriteString(tail_lines[i])
        }
    }

    w.Flush()
}
