return {
	RServe = function(unitTest)
		local R = RServe()
		unitTest:assertType(R, "RServe")
	end,
	luarserveevaluate = function(unitTest)
		local R = RServe{}
		local x = R:evaluate("x = 2")
		unitTest:assertEquals(#x[1][1], 1)
		unitTest:assertEquals(x[1][1][1], 2)
	end,
	evaluate = function(unitTest)
		local R = RServe{}
		local x = R:evaluate("x = 2")
		unitTest:assertEquals(#x[1][1], 1)
		unitTest:assertEquals(x[1][1][1], 2)

		x = R:evaluate("rnorm(100)")
		unitTest:assertEquals(#x[1][1], 100)

		x = R:evaluate("runif(1, 5.0, 7.5)")
		unitTest:assertEquals(#x[1][1], 1)
		unitTest:assert(x[1][1][1] > 5)
		unitTest:assert(x[1][1][1] < 7.5)

		x = R:evaluate("replicate(5, rnorm(7))")
		unitTest:assertEquals(#x[1][2], 35)
		unitTest:assertEquals(x[1][1][1][1][1], 7)
		unitTest:assertEquals(x[1][1][1][1][2], 5)

		x = R:evaluate("a <- c(1, 2, 5.3, 6, -2, 4)")
		unitTest:assertEquals(#x[1][1], 6)
		unitTest:assertEquals(x[1][1][1], 1)
		unitTest:assertEquals(x[1][1][2], 2)
		unitTest:assertEquals(x[1][1][3], 5.3)
		unitTest:assertEquals(x[1][1][4], 6)
		unitTest:assertEquals(x[1][1][5], -2)
		unitTest:assertEquals(x[1][1][6], 4)

		--bug commit separado
		x = R:evaluate("b <- c('one','two','three')")
		unitTest:assertEquals(#x[1][1], 3)
		unitTest:assertEquals(x[1][1][1], "one", 1)
		unitTest:assertEquals(x[1][1][2], "two", 1)
		unitTest:assertEquals(x[1][1][3], "three", 1)

		x = R:evaluate("c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE)")
		unitTest:assertEquals(#x[1][1], 6)
		unitTest:assertEquals(x[1][1][1], true)
		unitTest:assertEquals(x[1][1][2], true)
		unitTest:assertEquals(x[1][1][3], true)
		unitTest:assertEquals(x[1][1][4], false)
		unitTest:assertEquals(x[1][1][5], true)
		unitTest:assertEquals(x[1][1][6], false)

		x = R:evaluate("y <- matrix(1:20, nrow=5,ncol=4)")
		unitTest:assertEquals(#x[1][2], 20)
		unitTest:assertEquals(x[1][1][1][1][1], 5)
		unitTest:assertEquals(x[1][1][1][1][2], 4)
		unitTest:assertEquals(x[1][2][1], 1)
		unitTest:assertEquals(x[1][2][2], 2)
		unitTest:assertEquals(x[1][2][3], 3)
		unitTest:assertEquals(x[1][2][4], 4)
		unitTest:assertEquals(x[1][2][5], 5)
		unitTest:assertEquals(x[1][2][6], 6)
		unitTest:assertEquals(x[1][2][7], 7)
		unitTest:assertEquals(x[1][2][8], 8)
		unitTest:assertEquals(x[1][2][9], 9)
		unitTest:assertEquals(x[1][2][10], 10)
		unitTest:assertEquals(x[1][2][11], 11)
		unitTest:assertEquals(x[1][2][12], 12)
		unitTest:assertEquals(x[1][2][13], 13)
		unitTest:assertEquals(x[1][2][14], 14)
		unitTest:assertEquals(x[1][2][15], 15)
		unitTest:assertEquals(x[1][2][16], 16)
		unitTest:assertEquals(x[1][2][17], 17)
		unitTest:assertEquals(x[1][2][18], 18)
		unitTest:assertEquals(x[1][2][19], 19)
		unitTest:assertEquals(x[1][2][20], 20)

		x = R:evaluate("B = matrix(c(2, 4, 3, 1, 5, 7), nrow=3, ncol=2)")
		unitTest:assertEquals(#x[1][2], 6)
		unitTest:assertEquals(x[1][1][1][1][1], 3)
		unitTest:assertEquals(x[1][1][1][1][2], 2)
		unitTest:assertEquals(x[1][2][1], 2)
		unitTest:assertEquals(x[1][2][2], 4)
		unitTest:assertEquals(x[1][2][3], 3)
		unitTest:assertEquals(x[1][2][4], 1)
		unitTest:assertEquals(x[1][2][5], 5)
		unitTest:assertEquals(x[1][2][6], 7)

		x = R:evaluate("B = matrix(c(2, 4, 3, 1, 5, 7), nrow=2, ncol=3)")
		unitTest:assertEquals(#x[1][2], 6)
		unitTest:assertEquals(x[1][1][1][1][1], 2)
		unitTest:assertEquals(x[1][1][1][1][2], 3)
		unitTest:assertEquals(x[1][2][1], 2)
		unitTest:assertEquals(x[1][2][2], 4)
		unitTest:assertEquals(x[1][2][3], 3)
		unitTest:assertEquals(x[1][2][4], 1)
		unitTest:assertEquals(x[1][2][5], 5)
		unitTest:assertEquals(x[1][2][6], 7)

		x = R:evaluate("B = matrix(c(2, 4, 3, 1, 5, 7), nrow=2, ncol=3, byrow=TRUE)")
		unitTest:assertEquals(#x[1][2], 6)
		unitTest:assertEquals(x[1][1][1][1][1], 2)
		unitTest:assertEquals(x[1][1][1][1][2], 3)
		unitTest:assertEquals(x[1][2][1], 2)
		unitTest:assertEquals(x[1][2][2], 1)
		unitTest:assertEquals(x[1][2][3], 4)
		unitTest:assertEquals(x[1][2][4], 5)
		unitTest:assertEquals(x[1][2][5], 3)
		unitTest:assertEquals(x[1][2][6], 7)

		x = R:evaluate("B = matrix(c(2, 4, 3, 1, 5, 7), nrow=2, ncol=3, byrow=FALSE)")
		unitTest:assertEquals(#x[1][2], 6)
		unitTest:assertEquals(x[1][1][1][1][1], 2)
		unitTest:assertEquals(x[1][1][1][1][2], 3)
		unitTest:assertEquals(x[1][2][1], 2)
		unitTest:assertEquals(x[1][2][2], 4)
		unitTest:assertEquals(x[1][2][3], 3)
		unitTest:assertEquals(x[1][2][4], 1)
		unitTest:assertEquals(x[1][2][5], 5)
		unitTest:assertEquals(x[1][2][6], 7)

		x = R:evaluate("d <- c(1,2,3,4); e <- c('red', 'white', 'red', NA); f <- c(TRUE,TRUE,TRUE,FALSE); mydata <- data.frame(d,e,f)")
		unitTest:assertEquals(x[1][1][1][1][1], "d", 1)
		unitTest:assertEquals(x[1][1][1][1][2], "e", 1)
		unitTest:assertEquals(x[1][1][1][1][3], "f", 1)
		unitTest:assertEquals(x[1][2][1][1], 1)
		unitTest:assertEquals(x[1][2][1][2], 2)
		unitTest:assertEquals(x[1][2][1][3], 3)
		unitTest:assertEquals(x[1][2][1][4], 4)
		unitTest:assertEquals(x[1][2][2][1][1][1], "red", 1)
		unitTest:assertEquals(x[1][2][2][1][1][2], "white", 1)
		unitTest:assertEquals(x[1][2][4][1], true)
		unitTest:assertEquals(x[1][2][4][2], true)
		unitTest:assertEquals(x[1][2][4][3], true)
		unitTest:assertEquals(x[1][2][4][4], false)

		x = R:evaluate("d <- c(1,2,3,4); e <- c('red', 'white', 'red', NA); f <- c(TRUE,TRUE,TRUE,FALSE); mydata <- data.frame(d,e,f); names(mydata) <- c('ID','Color','Passed'); mydata")
		unitTest:assertEquals(x[1][1][1][1][1], "ID", 1)
		unitTest:assertEquals(x[1][1][1][1][2], "Color", 1)
		unitTest:assertEquals(x[1][1][1][1][3], "Passed", 1)
		unitTest:assertEquals(x[1][2][1][1], 1)
		unitTest:assertEquals(x[1][2][1][2], 2)
		unitTest:assertEquals(x[1][2][1][3], 3)
		unitTest:assertEquals(x[1][2][1][4], 4)
		unitTest:assertEquals(x[1][2][2][1][1][1], "red", 1)
		unitTest:assertEquals(x[1][2][2][1][1][2], "white", 1)
		unitTest:assertEquals(x[1][2][4][1], true)
		unitTest:assertEquals(x[1][2][4][2], true)
		unitTest:assertEquals(x[1][2][4][3], true)
		unitTest:assertEquals(x[1][2][4][4], false)

		x = R:evaluate("gender <- c(rep('male',2), rep('female', 3)); gender <- factor(gender)")
		unitTest:assertEquals(x[1][1][1][1][1], "female", 1)
		unitTest:assertEquals(x[1][1][1][1][2], "male", 1)
		unitTest:assertEquals(x[1][2][1], 2)
		unitTest:assertEquals(x[1][2][2], 2)
		unitTest:assertEquals(x[1][2][3], 1)
		unitTest:assertEquals(x[1][2][4], 1)
		unitTest:assertEquals(x[1][2][5], 1)

		x = R:evaluate("v <- c(1,3,5,8,2,1,3,5,3,5); x <- factor(v)")
		unitTest:assertEquals(x[1][1][1][1][1], "1", 1)
		unitTest:assertEquals(x[1][1][1][1][2], "2", 1)
		unitTest:assertEquals(x[1][1][1][1][3], "3", 1)
		unitTest:assertEquals(x[1][1][1][1][4], "5", 1)
		unitTest:assertEquals(x[1][1][1][1][5], "8", 1)
		unitTest:assertEquals(x[1][2][1], 1)
		unitTest:assertEquals(x[1][2][2], 3)
		unitTest:assertEquals(x[1][2][3], 4)
		unitTest:assertEquals(x[1][2][4], 5)
		unitTest:assertEquals(x[1][2][5], 2)
		unitTest:assertEquals(x[1][2][6], 1)
		unitTest:assertEquals(x[1][2][7], 3)
		unitTest:assertEquals(x[1][2][8], 4)
		unitTest:assertEquals(x[1][2][9], 3)
		unitTest:assertEquals(x[1][2][10], 4)

		x = R:evaluate("n <- c(2, 3, 5); s <- c('aa', 'bb', 'cc'); b <- c(TRUE, FALSE, TRUE); df <- data.frame(n, s, b)")
		unitTest:assertEquals(x[1][1][1][1][1], "n", 1)
		unitTest:assertEquals(x[1][1][1][1][2], "s", 1)
		unitTest:assertEquals(x[1][1][1][1][3], "b", 1)
		unitTest:assertEquals(x[1][2][1][1], 2)
		unitTest:assertEquals(x[1][2][1][2], 3)
		unitTest:assertEquals(x[1][2][1][3], 5)
		unitTest:assertEquals(x[1][2][3][1], 1)
		unitTest:assertEquals(x[1][2][3][2], 2)
		unitTest:assertEquals(x[1][2][3][3], 3)
		unitTest:assertEquals(x[1][2][4][1], true)
		unitTest:assertEquals(x[1][2][4][2], false)
		unitTest:assertEquals(x[1][2][4][3], true)

		x = R:evaluate("library(MASS); data(cats); lm(Hwt ~ Bwt, data=cats[1:5,])")
		unitTest:assertEquals(#x[1][2][20][1], 5)
		unitTest:assertEquals(#x[1][2][20][2], 5)
	end,
	__tostring = function(unitTest)
		unitTest:assertEquals(tostring(RServe{}), [[host  string [localhost]
port  number [6311]
]])
	end
}
