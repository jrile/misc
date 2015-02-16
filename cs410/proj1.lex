%{
 #include <string.h>
 int condition3a = 0, condition3b = 0, condition3c = 0, wivesEmployed = 0;
 int state = 0, wife = 0, head = 0, count = 0;
 int houseNum, isRr, i, j, numItems;
 int residentsBornInState[60] = {0};
 int childrenAge[5][12] = {0};
 
 enum state {
   LINE, HOUSENUM, DWELLNUM, FAMNUM, LNAME, FNAME, RELATIONSHIP, OWNORRENT, 
   ISFREE, SEX, RACE, AGE, STATUS, IMMIGRATIONYEAR, NATURALIZED, 
   NATURALIZATIONYEAR, SCHOOL, READ, WRITE, BIRTHPLACE, MOTHERTONGUE,
   FBIRTHPLACE, FMTONGUE, MBIRTHPLACE, MMTONGUE, ENGLISH, TRADE, INDUSTRY,
   EMPLOYER, NUMBERFARMSCHEDULE
 };

 const char* stateList[] = {
   "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", 
   "Delaware", "DC", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", 
   "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", 
   "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", 
   "New Hampshire", "New Jersey", "New Mexico","New York", "North Carolina", "North Dakota", 
   "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", 
   "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", 
   "West Virginia", "Wisconsin", "Wyoming", "Belgium", "England", "Germany", "Other" 
 };

 typedef struct s_neighbor {
   int houseNum;
   int isRailroader;
 } neighbor;

 neighbor neighborList[100];
 numItems = sizeof(stateList)/sizeof(stateList[0]);
%}
Digit [0-9]
%%
({Digit}{Digit}?-)?{Digit}{Digit}?\/12 {
  // child's age
  // possible formats: 1-1/12, 1-11/12, 1/12, 11/12
  int year = 0;
  int month;
  if(yytext[1] == '-') {
    year = yytext[0] - '0';
    if(isdigit(yytext[2]) && isdigit(yytext[3])) {
      month = ((yytext[2] - '0') * 10) + (yytext[3] - '0');
    }
    else {
      month = yytext[2] - '0';
    }
  }
  else {
    if(isdigit(yytext[0]) && isdigit(yytext[1])) {
      month = ((yytext[0] - '0') * 10) + (yytext[1] - '0');
    }
    else {
      month = yytext[0] - '0';
    }
  }
  childrenAge[year][month]++;
}
wife {
  wife = 1;
}
head {
  head = 1;
}
[^,^\n^\"]+ {
  // delimiter
  switch(state) {

  case HOUSENUM:
    // this will simply produce 0 if there is no valid house number.
    if(strlen(yytext)>0) {
      houseNum = atoi(yytext);
    }   
    break;

  case BIRTHPLACE:
    for(i=0; i<numItems; i++) {
      if(strcmp(yytext, stateList[i]) == 0) {
	residentsBornInState[i]++;
	break;
      } 
    }
    break;

  case TRADE:
    if(wife && (strlen(yytext) != 0) && (strcmp(yytext, "None") != 0)) {
      wivesEmployed++;
    }
    break;


  case INDUSTRY:
    isRr = 0; 
    if(strstr(yytext, "Railroad") != NULL) {
      isRr = 1;
    }
    if(houseNum && head) {
      neighbor n;
      n.houseNum = houseNum;
      n.isRailroader = isRr;
      neighborList[count] = n;
      count++;
    }
    break;

  default:
    // don't care about these fields
    break;
  }
}
\n	{ state = LINE; houseNum = 0; wife = 0; head = 0; }
,       { state++; }
\"      { }
%%
main() {

  yylex();

    for(i=0; i<numItems; i++) {
      if(residentsBornInState[i] > 0) {
	printf("%d people were born in %s.\n", residentsBornInState[i], stateList[i]);
      } 
    }


  for(i=0; i<5; i++) {
    for(j=0; j<12; j++) {
      if(childrenAge[i][j] != 0) {
	printf("There is/are %d child(ren) that is/are %d year(s) old and %d month(s).\n", childrenAge[i][j], i, j);
      }
    }
  }
  
  for(i=0; i<count; i++) {
    int atLeastOneNeighborIs = 0, atLeastOneNeighborIsnt = 0;
    if(!neighborList[i].isRailroader) {
      // head of household is not a railroader, so #3 does not apply to him.
      continue;
    }
    for(j=0; j<count; j++) {
      if(((neighborList[i].houseNum - neighborList[j].houseNum <= 4) && (neighborList[i].houseNum - neighborList[j].houseNum >= -4)) && (i != j)) {
	// we have a neighbor
	if(neighborList[j].isRailroader) {
	  atLeastOneNeighborIs = 1;
	}
	else {
	  atLeastOneNeighborIsnt = 1;
	}
      }
    }
    if(atLeastOneNeighborIs && !atLeastOneNeighborIsnt) {
      condition3a++;
    }
    else if(atLeastOneNeighborIs && atLeastOneNeighborIsnt) {
      condition3b++;
    }
    else {
      condition3c++;
    }
  }
  printf("Railroader heads that have neighbor heads that are all also railroaders: %d\n", condition3a);
  printf("Railroader heads that have some neighbor heads that are also railroaders: %d\n", condition3b);
  printf("Railroader heads that have no neighbor heads that are railroaders: %d\n", condition3c);
  
  printf("There is/are %d wife/wives that are employed.\n", wivesEmployed);

  
  return 0;
}
