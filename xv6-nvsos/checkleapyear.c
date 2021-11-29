#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc,char** argv) {
   int year;
   printf(1,"Enter a year: ");
   year=atoi(argv[1]);
   
   if (year % 400 == 0) {
      printf(1,"%d is a leap year.", year);
   }
   
   
   else if (year % 100 == 0) {
      printf(1,"%d is not a leap year.", year);
   }
   
   else if (year % 4 == 0) {
      printf(1,"%d is a leap year.", year);
   }
   
   else {
      printf(1,"%d is not a leap year.", year);
   }
   
exit();
}
