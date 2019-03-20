public class LoopsTasks {

    /**
     * Returns the 'Fizz','Buzz' or an original number as String using the following rules:
     * 1) return original number as String
     * 2) but if number multiples of three return 'Fizz'
     * 3) for the multiples of five return 'Buzz'
     * 4) for numbers which are multiples of both three and five return 'FizzBuzz'
     *
     * @param {number} num
     * @return {any}
     *
     * @example
     *   2 =>  '2'
     *   3 => 'Fizz'
     *   5 => 'Buzz'
     *   4 => '4'
     *  15 => 'FizzBuzz'
     *  20 => 'Buzz'
     *  21 => 'Fizz'
     *
     */
    public static String getFizzBuzz(Integer num) {
        String result = '';

        if (Math.mod(num, 3) == 0)
            result = 'Fizz';
        if (Math.mod(num, 5) == 0)
            result = result + 'Buzz';
        if (result.length() == 0)
            result = String.valueOf(num);

        return result;
    }

    /**
     * Returns the factorial of the specified integer n.
     *
     * @param {number} n
     * @return {number}
     *
     * @example:
     *   1  => 1
     *   5  => 120
     *   10 => 3628800
     */
    public static Integer getFactorial(Integer num) {
        if (num == 0) return 1;

        return num * getFactorial(num - 1);
    }

    /**
     * Returns the sum of integer numbers between n1 and n2 (inclusive).
     *
     * @param {number} n1
     * @param {number} n2
     * @return {number}
     *
     * @example:
     *   1,2   =>  3  ( = 1+2 )
     *   5,10  =>  45 ( = 5+6+7+8+9+10 )
     *   -1,1  =>  0  ( = -1 + 0 + 1 )
     */
    public static Integer getSumBetweenNumbers(Integer num1, Integer num2) {
        Integer result = 0;

        for (Integer i = num1; i <= num2; i++)
            result = result + i;

        return result;
    }

    /**
     * Returns true, if a triangle can be built with the specified sides a,b,c and false in any other ways.
     *
     * @param {number} a
     * @param {number} b
     * @param {number} c
     * @return {bool}
     *
     * @example:
     *   1,2,3    =>  false
     *   3,4,5    =>  true
     *   10,1,1   =>  false
     *   10,10,10 =>  true
     */
    public static Boolean isTriangle(Integer a, Integer b, Integer c) {
        Integer max;
        Integer rest;

        max = Math.max(a,b);
        max = Math.max(max,c);
        rest = a + b + c - max;

        return rest > max;
    }

    /**
     * Returns true, if two specified axis-aligned rectangles overlap, otherwise false.
     * Each rectangle representing by Map<String, Integer>
     *  {
     *     top: 5,
     *     left: 5,
     *     width: 20,
     *     height: 10
     *  }
     *
     *  (5;5)
     *     -------------
     *     |           |
     *     |           |  height = 10
     *     -------------
     *        width=20
     *
     * NOTE: Please use canvas coordinate space (https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API/Tutorial/Drawing_shapes#The_grid),
     * it differs from Cartesian coordinate system.
     *
     * @param {Map<String, Integer>} rect1
     * @param {Map<String, Integer>} rect2
     * @return {bool}
     *
     * @example:
     *   { top: 0, left: 0, width: 10, height: 10 },
     *   { top: 5, left: 5, width: 20, height: 20 }    =>  true
     *
     *   { top: 0, left: 0, width: 10, height: 10 },
     *   { top:20, left:20, width: 20, height: 20 }    =>  false
     *
     */
    public static Boolean doRectanglesOverlap(Map<String, Integer> rect1, Map<String, Integer> rect2) {
        rect1.put('right', rect1.get('left') + rect1.get('width'));
        rect2.put('right', rect2.get('left') + rect2.get('width'));
        rect1.put('bottom', rect1.get('top') + rect1.get('height'));
        rect2.put('bottom', rect2.get('top') + rect2.get('height'));
        
        if ((rect2.get('left') >= rect1.get('left')) &&  (rect2.get('left') <= rect1.get('right')) ||
                (rect2.get('right') >= rect1.get('left')) &&  (rect2.get('right') <= rect1.get('right'))) {
            if ((rect2.get('top') >=  rect1.get('top')) && (rect2.get('top') <=  rect1.get('bottom'))) return true;
            if ((rect2.get('bottom') >=  rect1.get('top')) && (rect2.get('bottom') <=  rect1.get('bottom'))) return true;
        }
           
        if ((rect1.get('left') >= rect2.get('left')) &&  (rect1.get('left') <= rect2.get('right')) ||
                (rect1.get('right') >= rect2.get('left')) &&  (rect1.get('right') <= rect2.get('right'))) {
            if ((rect1.get('top') >=  rect2.get('top')) && (rect1.get('top') <=  rect2.get('bottom'))) return true;
            if ((rect1.get('bottom') >=  rect2.get('top')) && (rect1.get('bottom') <=  rect2.get('bottom'))) return true;
        }

       return false;
    }

    /**
     * Returns true, if point lies inside the circle, otherwise false.
     * Circle is:
     *     Center Map<String, Double>: {
     *       x: 5,
     *       y: 5
     *     },
     *     Radius Integer: 20
     * Point is Map<String, Double>
     *  {
     *     x: 5,
     *     y: 5
     *  }
     *
     * @param {Map<String, Double>} center
     * @param {Integer} raduis
     * @param {Map<String, Double>} point
     * @return {bool}
     *
     * @example:
     *   center: { x:0, y:0 }, radius: 10, point: { x:0, y:0 }     => true
     *   center: { x:0, y:0 }, radius:10,  point: { x:10, y:10 }   => false
     *
     */
    public static Boolean isInsideCircle(Map<String, Double> center, Integer radius, Map<String, Double> point) {
        Double distX, distY, dist;

        distX = center.get('x') - point.get('x');
        distY = center.get('y') - point.get('y');
        dist = Math.sqrt(distX * distX + distY * distY);

        return (dist < radius);
    }

    /**
     * Returns the first non repeated char in the specified strings otherwise returns null.
     *
     * @param {string} str
     * @return {string}
     *
     * @example:
     *   'The quick brown fox jumps over the lazy dog' => 'T'
     *   'abracadabra'  => 'c'
     *   'entente' => null
     */
    public static String findFirstSingleChar(String str) {
        Integer cursor = 0;
        do {
            while ((str.countMatches(str.mid(cursor, 1)) == 1))
                cursor++;
            str = str.remove(str.mid(cursor, 1));
        } while (cursor < str.length());
        return (str.length() == 0)?null:str.mid(0, 1);
    }

    /**
     * Returns the string representation of math interval, specified by two points and include / exclude flags.
     * See the details: https://en.wikipedia.org/wiki/Interval_(mathematics)
     *
     * Please take attention, that the smaller number should be the first in the notation
     *
     * @param {number} a
     * @param {number} b
     * @param {bool} isStartIncluded
     * @param {bool} isEndIncluded
     * @return {string}
     *
     * @example
     *   0, 1, true, true   => '[0, 1]'
     *   0, 1, true, false  => '[0, 1)'
     *   0, 1, false, true  => '(0, 1]'
     *   0, 1, false, false => '(0, 1)'
     * Smaller number has to be first :
     *   5, 3, true, true   => '[3, 5]'
     *
     */
    public static String getIntervalString(Integer a, Integer b, Boolean isStartIncluded, Boolean isEndIncluded) {
        String min = String.valueOf(Math.min(a,b));
        String max = String.valueOf(Math.max(a,b));

        return (isStartIncluded?'[':'(') + min + ', ' + max + (isEndIncluded?']':')');
    }

    /**
     * Reverse the specified string (put all chars in reverse order)
     *
     * @param {string} str
     * @return {string}
     *
     * @example:
     * 'The quick brown fox jumps over the lazy dog' => 'god yzal eht revo spmuj xof nworb kciuq ehT'
     * 'abracadabra' => 'arbadacarba'
     * 'rotator' => 'rotator'
     * 'noon' => 'noon'
     */
    public static String reverseString(String str) {
        return str.reverse();
    }

    /**
     * Reverse the specified integer number (put all digits in reverse order)
     *
     * @param {number} num
     * @return {number}
     *
     * @example:
     *   12345 => 54321
     *   1111  => 1111
     *   87354 => 45378
     *   34143 => 34143
     */
    public static Integer reverseInteger(Integer num) {
        String raw = String.valueOf(num);
        Integer result = 0;

        for (Integer i = 0; i < raw.length(); i++) {
            result = result + Integer.valueOf(raw.mid(i, 1)) * (Integer)Math.pow(10, i);
        }

        return result;
    }

    /**
     * Returns the digital root of integer:
     *   step1 : find sum of all digits
     *   step2 : if sum > 9 then goto step1 otherwise return the sum
     *
     * @param {number} n
     * @return {number}
     *
     * @example:
     *   12345 ( 1+2+3+4+5 = 15, 1+5 = 6) => 6
     *   23456 ( 2+3+4+5+6 = 20, 2+0 = 2) => 2
     *   10000 ( 1+0+0+0+0 = 1 ) => 1
     *   165536 (1+6+5+5+3+6 = 26,  2+6 = 8) => 8
     */
    public static Integer getDigitalRoot(Integer num) {
        String digits = '0123456789';
        String source = String.valueOf(num);
        Integer result;
        do {
            result = 0;
            for (Integer i = 0; i < source.length(); i++)
                result = result + digits.indexOf(source.mid(i, 1));
            source = String.valueOf(result);
        } while (source.length() != 1);
        return result;
    }

    /**
     * Returns true if the specified string has the balanced brackets and false otherwise.
     * Balanced means that is, whether it consists entirely of pairs of opening/closing brackets
     * (in that order), none of which mis-nest.
     * Brackets include [],(),{},<>
     *
     * @param {string} str
     * @return {boolean}
     *
     * @example:
     *   '' => true
     *   '[]'  => true
     *   '{}'  => true
     *   '()'  => true
     *   '[[]' => false
     *   ']['  => false
     *   '[[][][[]]]' => true
     *   '[[][]][' => false
     *   '{)' = false
     *   '{[(<{[]}>)]}' = true
     */
    public static Boolean isBracketsBalanced(String str) {
        Integer previousLength;

        do {
            previousLength = str.length();
            str = str.remove('[]');
            str = str.remove('{}');
            str = str.remove('()');
            str = str.remove('<>');
        } while (previousLength != str.length());

        return (str.length() == 0);
    }

    /**
     * Returns the human readable string of time period specified by the start and end time.
     * The result string should be constrcuted using the folliwing rules:
     *
     * ---------------------------------------------------------------------
     *   Difference                 |  Result
     * ---------------------------------------------------------------------
     *    0 to 45 seconds           |  a few seconds ago
     *   45 to 90 seconds           |  a minute ago
     *   90 seconds to 45 minutes   |  2 minutes ago ... 45 minutes ago
     *   45 to 90 minutes           |  an hour ago
     *  90 minutes to 22 hours      |  2 hours ago ... 22 hours ago
     *  22 to 36 hours              |  a day ago
     *  36 hours to 25 days         |  2 days ago ... 25 days ago
     *  25 to 45 days               |  a month ago
     *  45 to 345 days              |  2 months ago ... 11 months ago
     *  345 to 545 days (1.5 years) |  a year ago
     *  546 days+                   |  2 years ago ... 20 years ago
     * ---------------------------------------------------------------------
     *
     * @param {DateTime} startDate
     * @param {DateTime} endDate
     * @return {string}
     *
     * @example
     *   DateTime('2000-01-01 01:00:00'), DateTime('2000-01-01 01:00:01')  => 'a few seconds ago'
     *   DateTime('2000-01-01 01:00:00'), DateTime('2000-01-01 01:00:05')  => '5 minutes ago'
     *   DateTime('2000-01-01 01:00:00'), DateTime('2000-01-02 03:00:05')  => 'a day ago'
     *   DateTime('2000-01-01 01:00:00'), DateTime('2015-01-02 03:00:05')  => '15 years ago'
     *
     */
    public static String timespanToHumanString(DateTime startDate, DateTime endDate) {

        Integer days = Math.abs(endDate.date().daysBetween(startDate.Date()));
        Integer hours = endDate.hour() - startDate.hour();
        Integer minutes = endDate.minute() - startDate.minute();
        Integer seconds = endDate.second() - startDate.second();

        if (days >= 546) 
            return String.valueOf(days/364) + ' years ago';
        if ((days >= 345) && (days < 546)) 
            return 'a year ago';
        if ((days > 45) && (days < 345)) 
            return String.valueOf(Math.round(days/30.0)) + ' months ago';
        if ((days > 25) && (days <= 45)) 
            return 'a month ago';
        if ((days == 25) && ((hours != 0) || (minutes != 0) || (seconds != 0))) 
            return 'a month ago';
        if ((days >= 2) && (days <= 25)) 
            return String.valueOf(days) + ' days ago';
        if ((days == 1) && (hours > 12)) 
            return '2 days ago';
        if ((days == 1) && (hours == 12) && ((minutes != 0) || (seconds != 0))) 
            return '2 days ago';
        
        hours = hours + days * 24;
        if ((hours > 22) && (hours <= 36)) 
            return 'a day ago';
        if ((hours == 22) && ((minutes != 0) || (seconds != 0))) 
            return 'a day ago';
        if (hours == 22) 
            return '22 hours ago';
        if ((hours >= 2) && (hours < 22) && ((minutes > 30) || ((minutes == 30) && (seconds > 0)))) 
            return String.valueOf(hours + 1) + ' hours ago';
        if ((hours >= 2) && (hours < 22) && ((minutes < 30) || ((minutes == 30) && (seconds == 0)))) 
            return String.valueOf(hours) + ' hours ago';
        if ((hours == 1) && ((minutes > 30) || ((minutes == 30) && (seconds > 0)))) 
            return '2 hours ago';
        
        minutes = minutes + hours * 60;
        if (((minutes > 45) || ((minutes == 45) && (seconds > 0)) ) && (minutes <= 90)) 
            return 'an hour ago';
        if ((minutes >= 2) && (minutes <= 45)) 
            return String.valueOf(minutes) + ' minutes ago';
        if ((minutes == 1) && (seconds > 30)) 
            return '2 minutes ago';
        seconds = seconds + minutes * 60; 
        if ((seconds > 45) && (seconds <= 90)) 
            return 'a minute ago';
        
        return 'a few seconds ago';
    }
}