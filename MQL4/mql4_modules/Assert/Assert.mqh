/**
 * This is assertion macro.
 * Checks if assertion is FALSE when IS_ASSERT is defined
 * this macro will check the given 'condition' and take stop the program
 * if its result is FALSE.
 *
 * @param bool   condition   Expression to be checked.
 * @param string message     If condition false, Alert this message.
 *
 * @example assert(lots > 0, "invalid lots");
 */
#ifndef assert
   #ifdef IS_ASSERT
      #define assert(condition, message) \
         if(!(condition)) { \
            Alert("Assertion failed! ", \ 
                  #condition, ", ", \ 
                  __FILE__, ", ", \
                  __FUNCSIG__, ", ", \
                  "line:", __LINE__, ", ", \
                  message); \
            \
            if(MQLInfoInteger(MQL_PROGRAM_TYPE) == PROGRAM_EXPERT) { \
               ExpertRemove();\
            } \
            else if(MQLInfoInteger(MQL_PROGRAM_TYPE) == PROGRAM_INDICATOR) { \
               if(!ChartIndicatorDelete(0, \
                                        ChartWindowOnDropped(), \
                                        MQLInfoString(MQL_PROGRAM_NAME))) { \
                  IndicatorSetString(INDICATOR_SHORTNAME, "assert"); \
                  ChartIndicatorDelete(0, \
                                       ChartWindowOnDropped(), \
                                       "assert"); \
               } \
            } \
         }
   #else
      #define assert(condition, message)
   #endif
#endif