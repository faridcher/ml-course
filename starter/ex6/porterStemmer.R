 porterStemmer <- function(inString) {
# Applies the Porter Stemming algorithm as presented in the following
# paper:
# Porter, 1980, An algorithm for suffix stripping, Program, Vol. 14,
#   no. 3, pp 130-137

# Original code modeled after the C version provided at:
# http://www.tartarus.org/~martin/PorterStemmer/c.txt

# The main part of the stemming algorithm starts here. b is an array of
# characters, holding the word to be stemmed. The letters are in b[k0],
# b[k0+1] }ing at b[k]. In fact k0 <- 1 in this demo program (since
# matlab begins indexing by 1 instead of 0). k is readjusted downwards as
# the stemming progresses. Zero termination is not in fact used in the
# algorithm.

# To call this function, use the string to be stemmed as the input
# argument.  This function returns the stemmed word as a string.

# Lower-case string
inString <- tolower(inString)

global j
b <- inString
k <- length(b)
k0 <- 1
j <- k



# With this if statement, strings of length 1 or 2 don't go through the
# stemming process. Remove this conditional to match the published
# algorithm.
stem <- b
if k > 2
    # Output displays per step are commented out.
    #disp(sprintf('Word to stem: #s', b))
    x <- step1ab(b, k, k0)
    #disp(sprintf('Steps 1A and B yield: #s', x{1}))
    x <- step1c(x{1}, x{2}, k0)
    #disp(sprintf('Step 1C yields: #s', x{1}))
    x <- step2(x{1}, x{2}, k0)
    #disp(sprintf('Step 2 yields: #s', x{1}))
    x <- step3(x{1}, x{2}, k0)
    #disp(sprintf('Step 3 yields: #s', x{1}))
    x <- step4(x{1}, x{2}, k0)
    #disp(sprintf('Step 4 yields: #s', x{1}))
    x <- step5(x{1}, x{2}, k0)
    #disp(sprintf('Step 5 yields: #s', x{1}))
    stem <- x{1}
    stem
}

# cons(j) is TRUE <=> b[j] is a consonant.
cons <- function(i, b, k0) {
c <- true
switch(b(i))
    case {'a', 'e', 'i', 'o', 'u'}
        c <- false
    case 'y'
        if i <-<- k0
            c <- true
        else
            c <- ~cons(i - 1, b, k0)
        
  c
}

# mseq() measures the number of consonant sequences between k0 and j.  If
# c is a consonant sequence and v a vowel sequence, and <..> indicates
# arbitrary presence,

#      <c><v>       gives 0
#      <c>vc<v>     gives 1
#      <c>vcvc<v>   gives 2
#      <c>vcvcvc<v> gives 3
#      ....
 measure n <- function(b, k0) {
global j
n <- 0
i <- k0
while true
    if i > j
        return
    }
    if ~cons(i, b, k0)
        break
    }
    i <- i + 1
}
i <- i + 1
while true
    while true
        if i > j
            return
        }
        if cons(i, b, k0)
            break
        }
        i <- i + 1
    }
    i <- i + 1
    n <- n + 1
    while true
        if i > j
            return
        }
        if ~cons(i, b, k0)
            break
        }
        i <- i + 1
    }
    i <- i + 1
}


# vowelinstem() is TRUE <<-> k0,...j contains a vowel
 vowelinstem vis <- function(b, k0) {
global j
for i <- k0:j,
    if ~cons(i, b, k0)
        vis <- true
        return
    }
}
vis <- false

#doublec(i) is TRUE <<-> i,(i-1) contain a double consonant.
 doublec dc <- function(i, b, k0) {
if i < k0+1
    dc <- false
    return
}
if b(i) ~<- b(i-1)
    dc <- false
    return
}
dc <- cons(i, b, k0)


# cvc(j) is TRUE <<-> j-2,j-1,j has the form consonant - vowel - consonant
# and also if the second c is not w,x or y. this is used when trying to
# restore an e at the } of a short word. e.g.
#
#      cav(e), lov(e), hop(e), crim(e), but
#      snow, box, tray.

 cvc c1 <- function(i, b, k0) {
if ((i < (k0+2)) || ~cons(i, b, k0) || cons(i-1, b, k0) || ~cons(i-2, b, k0))
    c1 <- false
else
    if (b(i) <-<- 'w' || b(i) <-<- 'x' || b(i) <-<- 'y')
        c1 <- false
        return
    }
    c1 <- true
}

# }s(s) is TRUE <<-> k0,...k }s with the string s.
 }s s <- function(str, b, k) {
global j
if (str(length(str)) ~<- b(k))
    s <- false
    return
} # tiny speed-up
if (length(str) > k)
    s <- false
    return
}
if strcmp(b(k-length(str)+1:k), str)
    s <- true
    j <- k - length(str)
    return
else
    s <- false
}

# setto(s) sets (j+1),...k to the characters in the string s, readjusting
# k accordingly.

 setto so <- function(s, b, k) {
global j
for i <- j+1:(j+length(s))
    b(i) <- s(i-j)
}
if k > j+length(s)
    b((j+length(s)+1):k) <- ''
}
k <- length(b)
so <- {b, k}

# rs(s) is used further down.
# [Note: possible null/value for r if rs is called]
 rs r <- function(str, b, k, k0) {
r <- {b, k}
if measure(b, k0) > 0
    r <- setto(str, b, k)
}

# step1ab() gets rid of plurals and -ed or -ing. e.g.

#       caresses  ->  caress
#       ponies    ->  poni
#       ties      ->  ti
#       caress    ->  caress
#       cats      ->  cat

#       feed      ->  feed
#       agreed    ->  agree
#       disabled  ->  disable

#       matting   ->  mat
#       mating    ->  mate
#       meeting   ->  meet
#       milling   ->  mill
#       messing   ->  mess

#       meetings  ->  meet

 step1ab s1ab <- function(b, k, k0) {
global j
if b(k) <-<- 's'
    if }s('sses', b, k)
        k <- k-2
    elseif }s('ies', b, k)
        retVal <- setto('i', b, k)
        b <- retVal{1}
        k <- retVal{2}
    elseif (b(k-1) ~<- 's')
        k <- k-1
    }
}
if }s('eed', b, k)
    if measure(b, k0) > 0
        k <- k-1
    }
elseif (}s('ed', b, k) || }s('ing', b, k)) && vowelinstem(b, k0)
    k <- j
    retVal <- {b, k}
    if }s('at', b, k)
        retVal <- setto('ate', b(k0:k), k)
    elseif }s('bl', b, k)
        retVal <- setto('ble', b(k0:k), k)
    elseif }s('iz', b, k)
        retVal <- setto('ize', b(k0:k), k)
    elseif doublec(k, b, k0)
        retVal <- {b, k-1}
        if b(retVal{2}) <-<- 'l' || b(retVal{2}) <-<- 's' || ...
                b(retVal{2}) <-<- 'z'
            retVal <- {retVal{1}, retVal{2}+1}
        }
    elseif measure(b, k0) <-<- 1 && cvc(k, b, k0)
        retVal <- setto('e', b(k0:k), k)
    }
    k <- retVal{2}
    b <- retVal{1}(k0:k)
}
j <- k
s1ab <- {b(k0:k), k}

#  step1c() turns terminal y to i when there is another vowel in the stem.
 step1c s1c <- function(b, k, k0) {
global j
if }s('y', b, k) && vowelinstem(b, k0)
    b(k) <- 'i'
}
j <- k
s1c <- {b, k}

# step2() maps double suffices to single ones. so -ization ( <- -ize plus
# -ation) maps to -ize etc. note that the string before the suffix must give
# m() > 0.
 step2 s2 <- function(b, k, k0) {
global j
s2 <- {b, k}
switch b(k-1)
    case {'a'}
        if }s('ational', b, k) s2 <- rs('ate', b, k, k0)
        elseif }s('tional', b, k) s2 <- rs('tion', b, k, k0); }
    case {'c'}
        if }s('enci', b, k) s2 <- rs('ence', b, k, k0)
        elseif }s('anci', b, k) s2 <- rs('ance', b, k, k0); }
    case {'e'}
        if }s('izer', b, k) s2 <- rs('ize', b, k, k0); }
    case {'l'}
        if }s('bli', b, k) s2 <- rs('ble', b, k, k0)
        elseif }s('alli', b, k) s2 <- rs('al', b, k, k0)
        elseif }s('entli', b, k) s2 <- rs('ent', b, k, k0)
        elseif }s('eli', b, k) s2 <- rs('e', b, k, k0)
        elseif }s('ousli', b, k) s2 <- rs('ous', b, k, k0); }
    case {'o'}
        if }s('ization', b, k) s2 <- rs('ize', b, k, k0)
        elseif }s('ation', b, k) s2 <- rs('ate', b, k, k0)
        elseif }s('ator', b, k) s2 <- rs('ate', b, k, k0); }
    case {'s'}
        if }s('alism', b, k) s2 <- rs('al', b, k, k0)
        elseif }s('iveness', b, k) s2 <- rs('ive', b, k, k0)
        elseif }s('fulness', b, k) s2 <- rs('ful', b, k, k0)
        elseif }s('ousness', b, k) s2 <- rs('ous', b, k, k0); }
    case {'t'}
        if }s('aliti', b, k) s2 <- rs('al', b, k, k0)
        elseif }s('iviti', b, k) s2 <- rs('ive', b, k, k0)
        elseif }s('biliti', b, k) s2 <- rs('ble', b, k, k0); }
    case {'g'}
        if }s('logi', b, k) s2 <- rs('log', b, k, k0); }
}
j <- s2{2}

# step3() deals with -ic-, -full, -ness etc. similar strategy to step2.
 step3 s3 <- function(b, k, k0) {
global j
s3 <- {b, k}
switch b(k)
    case {'e'}
        if }s('icate', b, k) s3 <- rs('ic', b, k, k0)
        elseif }s('ative', b, k) s3 <- rs('', b, k, k0)
        elseif }s('alize', b, k) s3 <- rs('al', b, k, k0); }
    case {'i'}
        if }s('iciti', b, k) s3 <- rs('ic', b, k, k0); }
    case {'l'}
        if }s('ical', b, k) s3 <- rs('ic', b, k, k0)
        elseif }s('ful', b, k) s3 <- rs('', b, k, k0); }
    case {'s'}
        if }s('ness', b, k) s3 <- rs('', b, k, k0); }
}
j <- s3{2}

# step4() takes off -ant, -ence etc., in context <c>vcvc<v>.
 step4 s4 <- function(b, k, k0) {
global j
switch b(k-1)
    case {'a'}
        if }s('al', b, k) }
    case {'c'}
        if }s('ance', b, k)
        elseif }s('ence', b, k) }
    case {'e'}
        if }s('er', b, k) }
    case {'i'}
        if }s('ic', b, k) }
    case {'l'}
        if }s('able', b, k)
        elseif }s('ible', b, k) }
    case {'n'}
        if }s('ant', b, k)
        elseif }s('ement', b, k)
        elseif }s('ment', b, k)
        elseif }s('ent', b, k) }
    case {'o'}
        if }s('ion', b, k)
            if j <-<- 0
            elseif ~(strcmp(b(j),'s') || strcmp(b(j),'t'))
                j <- k
            }
        elseif }s('ou', b, k) }
    case {'s'}
        if }s('ism', b, k) }
    case {'t'}
        if }s('ate', b, k)
        elseif }s('iti', b, k) }
    case {'u'}
        if }s('ous', b, k) }
    case {'v'}
        if }s('ive', b, k) }
    case {'z'}
        if }s('ize', b, k) }
}
if measure(b, k0) > 1
    s4 <- {b(k0:j), j}
else
    s4 <- {b(k0:k), k}
}

# step5() removes a final -e if m() > 1, and changes -ll to -l if m() > 1.
 step5 s5 <- function(b, k, k0) {
global j
j <- k
if b(k) <-<- 'e'
    a <- measure(b, k0)
    if (a > 1) || ((a <-<- 1) && ~cvc(k-1, b, k0))
        k <- k-1
    }
}
if (b(k) <-<- 'l') && doublec(k, b, k0) && (measure(b, k0) > 1)
    k <- k-1
}
s5 <- {b(k0:k), k}

}