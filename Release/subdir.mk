################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
O_SRCS += \
../cpucycles.o 

C_SRCS += \
../_main.c \
../test_bunyamin.c \
../test_huseyin.c \
../test_huseyin2.c 

S_UPPER_SRCS += \
../mul_2e256mc_x8664_asm_recursive.S \
../mul_c.S \
../mul_n.S \
../mul_n_v2.S 

OBJS += \
./_main.o \
./mul_2e256mc_x8664_asm_recursive.o \
./mul_c.o \
./mul_n.o \
./mul_n_v2.o \
./test_bunyamin.o \
./test_huseyin.o \
./test_huseyin2.o 

C_DEPS += \
./_main.d \
./test_bunyamin.d \
./test_huseyin.d \
./test_huseyin2.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

%.o: ../%.S
	@echo 'Building file: $<'
	@echo 'Invoking: GCC Assembler'
	as  -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


