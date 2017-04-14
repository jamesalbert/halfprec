; ── ── ── ── ── ██ ██ ██ ██ ██ ██ ── ── ── ── ──
; ── ── ── ██ ██ ██ ▓▓ ░░ ░░ ▓▓ ██ ██ ██ ── ── ──
; ── ── ██ ██ ▓▓ ▓▓ ▓▓ ░░ ░░ ▓▓ ▓▓ ▓▓ ██ ██ ── ──
; ── ██ ██ ░░ ▓▓ ▓▓ ░░ ░░ ░░ ░░ ▓▓ ▓▓ ░░ ██ ██ ──
; ── ██ ▓▓ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ▓▓ ██ ──
; ██ ██ ▓▓ ▓▓ ░░ ░░ ▓▓ ▓▓ ▓▓ ▓▓ ░░ ░░ ▓▓ ▓▓ ██ ██
; ██ ▓▓ ▓▓ ▓▓ ░░ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ░░ ▓▓ ▓▓ ▓▓ ██
; ██ ▓▓ ▓▓ ▓▓ ░░ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ░░ ▓▓ ▓▓ ▓▓ ██
; ██ ▓▓ ▓▓ ░░ ░░ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ▓▓ ░░ ░░ ▓▓ ▓▓ ██
; ██ ░░ ░░ ░░ ░░ ░░ ▓▓ ▓▓ ▓▓ ▓▓ ░░ ░░ ░░ ░░ ░░ ██
; ██ ░░ ░░ ██ ██ ██ ██ ██ ██ ██ ██ ██ ██ ░░ ░░ ██
; ██ ██ ██ ██ ░░ ░░ ██ ░░ ░░ ██ ░░ ░░ ██ ██ ██ ██
; ── ██ ██ ░░ ░░ ░░ ██ ░░ ░░ ██ ░░ ░░ ░░ ██ ██ ──
; ── ── ██ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ██ ── ──
; ── ── ██ ██ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ░░ ██ ██ ── ──
; ── ── ── ██ ██ ██ ██ ██ ██ ██ ██ ██ ██ ── ── ── halfprec

global half2float
global float2half
global double2half
global half2double


SECTION .text

half2float:
  push rbp
  mov rbp, rsp
  mov qword [rbp-18H], rdi
  mov qword [rbp-20H], rsi
  mov dword [rbp-24H], edx
  mov dword [rbp-4H], 0
  jmp L4

float2half:
  push rbp
  mov rbp, rsp
  mov qword [rbp-28H], rdi
  mov qword [rbp-30H], rsi
  mov dword [rbp-34H], edx
  mov dword [rbp-4H], 0
  jmp L12

half2double:
  push rbp
  mov rbp, rsp
  push r12
  push rbx
  sub rsp, 64
  mov qword [rbp-38H], rdi
  mov qword [rbp-40H], rsi
  mov dword [rbp-44H], edx
  mov rax, rsp
  mov r12, rax
  mov eax, dword [rbp-44H]
  movsxd rdx, eax
  sub rdx, 1
  mov qword [rbp-20H], rdx
  movsxd rdx, eax
  mov r8, rdx
  mov r9d, 0
  movsxd rdx, eax
  mov rcx, rdx
  mov ebx, 0
  cdqe
  shl rax, 2
  lea rdx, [rax+3H]
  mov eax, 16
  sub rax, 1
  add rax, rdx
  mov ebx, 16
  mov edx, 0
  div rbx
  imul rax, rax, 16
  sub rsp, rax
  mov rax, rsp
  add rax, 3
  shr rax, 2
  shl rax, 2
  mov qword [rbp-28H], rax
  mov rcx, qword [rbp-28H]
  mov edx, dword [rbp-44H]
  mov rax, qword [rbp-38H]
  mov rsi, rcx
  mov rdi, rax
  call half2float
  mov dword [rbp-14H], 0
  jmp L16

double2half:
  push rbp
  mov rbp, rsp
  push r12
  push rbx
  sub rsp, 64
  mov qword [rbp-38H], rdi
  mov qword [rbp-40H], rsi
  mov dword [rbp-44H], edx
  mov rax, rsp
  mov r12, rax
  mov eax, dword [rbp-44H]
  movsxd rdx, eax
  sub rdx, 1
  mov qword [rbp-20H], rdx
  movsxd rdx, eax
  mov r8, rdx
  mov r9d, 0
  movsxd rdx, eax
  mov rcx, rdx
  mov ebx, 0
  cdqe
  shl rax, 2
  lea rdx, [rax+3H]
  mov eax, 16
  sub rax, 1
  add rax, rdx
  mov ebx, 16
  mov edx, 0
  div rbx
  imul rax, rax, 16
  sub rsp, rax
  mov rax, rsp
  add rax, 3
  shr rax, 2
  shl rax, 2
  mov qword [rbp-28H], rax
  mov dword [rbp-14H], 0
  jmp L14

L1:
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax+rax]
  mov rax, qword [rbp-18H]
  add rax, rdx
  movzx eax, word [rax]
  movzx eax, ax
  and eax, 7FFFH
  mov dword [rbp-8H], eax
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax+rax]
  mov rax, qword [rbp-18H]
  add rax, rdx
  movzx eax, word [rax]
  movzx eax, ax
  and eax, 8000H
  mov dword [rbp-0CH], eax
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax+rax]
  mov rax, qword [rbp-18H]
  add rax, rdx
  movzx eax, word [rax]
  movzx eax, ax
  and eax, 7C00H
  mov dword [rbp-10H], eax
  shl dword [rbp-8H], 13
  shl dword [rbp-0CH], 16
  add dword [rbp-8H], 939524096
  cmp dword [rbp-10H], 0
  jz L2
  mov eax, dword [rbp-8H]
  jmp L3

L2:
  mov eax, 0

L3:
  mov dword [rbp-8H], eax
  mov eax, dword [rbp-0CH]
  or dword [rbp-8H], eax
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax*4]
  mov rax, qword [rbp-20H]
  add rdx, rax
  mov eax, dword [rbp-8H]
  mov dword [rdx], eax
  add dword [rbp-4H], 1

L4:
  mov eax, dword [rbp-4H]
  cmp eax, dword [rbp-24H]
  jl L1
  pop rbp
  ret

L5:
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax*4]
  mov rax, qword [rbp-28H]
  add rax, rdx
  mov eax, dword [rax]
  mov dword [rbp-8H], eax
  mov eax, dword [rbp-8H]
  and eax, 7FFFFFFFH
  mov dword [rbp-0CH], eax
  mov eax, dword [rbp-8H]
  and eax, 80000000H
  mov dword [rbp-10H], eax
  mov eax, dword [rbp-8H]
  and eax, 7F800000H
  mov dword [rbp-14H], eax
  shr dword [rbp-0CH], 13
  shr dword [rbp-10H], 16
  sub dword [rbp-0CH], 114688
  cmp dword [rbp-14H], 947912703
  jbe L6
  mov eax, dword [rbp-0CH]
  jmp L7

L6:
  mov eax, 0

L7:
  mov dword [rbp-0CH], eax
  cmp dword [rbp-14H], 1191182336
  ja L8
  mov eax, dword [rbp-0CH]
  jmp L9

L8:
  mov eax, 31743

L9:
  mov dword [rbp-0CH], eax
  cmp dword [rbp-14H], 0
  jz L10
  mov eax, dword [rbp-0CH]
  jmp L11

L10:
  mov eax, 0

L11:
  mov dword [rbp-0CH], eax
  mov eax, dword [rbp-10H]
  or dword [rbp-0CH], eax
  mov eax, dword [rbp-4H]
  cdqe
  lea rdx, [rax+rax]
  mov rax, qword [rbp-30H]
  add rdx, rax
  mov eax, dword [rbp-0CH]
  mov word [rdx], ax
  add dword [rbp-4H], 1

L12:
  mov eax, dword [rbp-4H]
  cmp eax, dword [rbp-34H]
  jl L5
  pop rbp
  ret

L13:
  mov eax, dword [rbp-14H]
  cdqe
  lea rdx, [rax*8]
  mov rax, qword [rbp-38H]
  add rax, rdx
  movsd xmm0, qword [rax]
  unpcklpd xmm0, xmm0
  cvtpd2ps xmm0, xmm0
  mov rax, qword [rbp-28H]
  mov edx, dword [rbp-14H]
  movsxd rdx, edx
  movss dword [rax+rdx*4], xmm0
  add dword [rbp-14H], 1

L14:
  mov eax, dword [rbp-14H]
  cmp eax, dword [rbp-44H]
  jl L13
  mov rax, qword [rbp-28H]
  mov edx, dword [rbp-44H]
  mov rcx, qword [rbp-40H]
  mov rsi, rcx
  mov rdi, rax
  call float2half
  mov rsp, r12
  lea rsp, [rbp-10H]
  pop rbx
  pop r12
  pop rbp
  ret

L15:
  mov eax, dword [rbp-14H]
  cdqe
  lea rdx, [rax*8]
  mov rax, qword [rbp-40H]
  lea rcx, [rdx+rax]
  mov rax, qword [rbp-28H]
  mov edx, dword [rbp-14H]
  movsxd rdx, edx
  movss xmm0, dword [rax+rdx*4]
  unpcklps xmm0, xmm0
  cvtps2pd xmm0, xmm0
  movsd qword [rcx], xmm0
  add dword [rbp-14H], 1

L16:
  mov eax, dword [rbp-14H]
  cmp eax, dword [rbp-44H]
  jl L15
  mov rsp, r12
  lea rsp, [rbp-10H]
  pop rbx
  pop r12
  pop rbp
  ret
