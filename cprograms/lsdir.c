#include <sys/types.h>
#include <sys/stat.h>
 #include <stdio.h>
#include <dirent.h>
int main(int argc, char *argv[]) {
   DIR *dir;
   struct dirent *direntry; /* Returned by readdir() */
   struct stat statbuf; /* Address of statbuf used by 
lstat() */
   mode_t file_type, file_perm;
   if(argc < 2){
      printf("Directory not specified\n") ;
      exit(1);}
   if ((dir = opendir(argv[1])) == NULL){
      perror("Couldn't open directory");
      exit(2);}
   if ((chdir(argv[1]) == -1)){ /* Change to the 
directory before */
      perror("chdir");
      exit(3);}
    /* you starting reading its entries */
   while ((direntry = readdir(dir)) != NULL) { /* Read 
each entry in directory*/
      if (lstat(direntry->d_name, &statbuf) < 0) { /* 
dname must be in */
          perror("lstat"); /* current directory */
          continue;
      }
      if (S_ISDIR(statbuf.st_mode)) { /* If file is a 
directory */
          file_type = statbuf.st_mode & S_IFMT;
          file_perm = statbuf.st_mode & ~S_IFMT;
          printf("%o %4o %s\n", file_type, file_perm, 
direntry->d_name);
      } 
   }
   exit(0);
}
