alphabet <- paste(letters, collapse='')
encipher <- function(string, cipher) chartr(alphabet, cipher, string)
decipher <- function(cryptstring, cipher) chartr(cipher, alphabet, cryptstring)

generate.random.cipher <- function() paste(sample(letters), collapse='')

propose.modified.cipher <- function(cipher){
	in_position <- sample(seq_along(letters),1)
	in_char <- substr(cipher, in_position, in_position)
	out_char <- sample(letters, 1)
	old_order <- paste0(in_char, out_char)
	new_order <- paste0(out_char, in_char)
	chartr(old_order, new_order, cipher)
}

lexmap_factory <- function(){
	load(file.path('data', 'lexical_database.Rdata'))

	LEXMAP <- new.env(size=length(lexical.database))
	for (i in seq_along(lexical.database))
		LEXMAP[[ names(lexical.database)[i] ]] <- log(lexical.database[[i]])

	MIN_SCORE <- log(.Machine$double.eps)

	function(text_vec){
		log_prob_list <- mget(text_vec, env=LEXMAP, ifnotfound=MIN_SCORE)
		sum(unlist(log_prob_list))
	}
}

log.probability.of.text <- lexmap_factory()

metropolis.step <- function(cipher.text, cipher){
	proposed.cipher <- propose.modified.cipher(cipher)

	lp1 <- log.probability.of.text(encipher(cipher.text, cipher))
	lp2 <- log.probability.of.text(encipher(cipher.text, proposed.cipher))

	if (lp2 > lp1) {
		proposed.cipher
	} else {
		a <- exp(lp2 - lp1)
		x <- runif(1)

		if (x < a) {
			proposed.cipher
		} else {
			cipher
		}
	}
}

break_cipher <- function(encrypted.text, decrypted.text="optional", 
					number.of.iterations=50000, seed=1, verbose=FALSE){
	set.seed(seed)
	cipher <- generate.random.cipher()

	results <- matrix( character(5 * number.of.iterations), nrow=number.of.iterations)
	for (iteration in 1:number.of.iterations){
		# If we were trying to find the original cipher, we would use "decipher";
		# we are looking for the inverse cipher.
		guessed.text <- encipher(encrypted.text, cipher)

		log.probability <- log.probability.of.text(guessed.text)

		correct.text <- as.integer( all(guessed.text == decrypted.text) )

		results[iteration,] <- c(	Iteration = iteration,
					LogProbability = log.probability,
					CurrentDecryptedText = paste(guessed.text, collapse = ' '),
					cipher = cipher,
					CorrectText = correct.text)
		
		cipher <- metropolis.step(encrypted.text, cipher)

		if ( (iteration %% 1000 == 0) & verbose )
			print(paste(c(results[iteration,]), collapse=' '))
	}
	results <- as.data.frame(results, stringsAsFactors=F)
	names(results) <- c('Iteration','LogProbability','CurrentDecryptedText','cipher','CorrectText')
	results$Iteration <- as.integer(results$Iteration)
	results$LogProbability <- as.numeric(results$LogProbability)
	
	results
}

run_iterations <- function(number.of.iterations){
	decrypted.text <- c('here', 'is', 'some', 'sample', 'text')
	caesar <- paste(letters[seq_along(letters) %% 26 + 1], collapse='')
	encrypted.text <- encipher(decrypted.text, caesar)
	break_cipher(encrypted.text, decrypted.text, number.of.iterations)
}