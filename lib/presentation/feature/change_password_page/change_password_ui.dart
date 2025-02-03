import 'package:flutter/material.dart';
import 'package:github_repo_list/presentation/common/extension/build_ext.dart';
import 'package:github_repo_list/presentation/common/extension/build_for_ext.dart';
import 'package:github_repo_list/presentation/common/widgets/edit_button.dart';
import 'package:github_repo_list/presentation/common/widgets/primary_button.dart';
import 'package:github_repo_list/presentation/feature/change_password_page/change_password_view_model.dart';
import 'package:github_repo_list/presentation/common/widgets/custom_text_field.dart';

class ChangePasswordUi extends StatefulWidget {
  static String routeName = '/change_password';
  const ChangePasswordUi({super.key});

  @override
  State<ChangePasswordUi> createState() => _ChangePasswordUiState();
}

class _ChangePasswordUiState extends State<ChangePasswordUi> {
  final viewModel = ChangePasswordViewModel();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  void clearTextFields() {
    _oldPasswordController.clear();
    _newPasswordController.clear();
    _confirmNewPasswordController.clear();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildHeaders(context),
            const SizedBox(height: 24),
            _oldPasswordTextField(context),
            const SizedBox(height: 24),
            _newPasswordTextField(context),
            const SizedBox(height: 24),
            _confirmNewPasswordTextField(context),
            const SizedBox(height: 40),
            _buildUpdateButton(context),
            const SizedBox(height: 60),
            _buildSuccessMessage(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaders(BuildContext context) {
    return Row(
      children: [
        Text(
          "Please fill the forms",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
              ),
        ),
        const Spacer(),
        viewModel.passwordStates.build(
          buildWhen: (prev, now) {
            return prev.isPasswordEditMode != now.isPasswordEditMode;
          },
          builder: (context, states) {
            return Visibility(
              visible: !states.isPasswordEditMode,
              child: EditButton(
                onPressed: () => viewModel.togglePasswordEditBtnState(true),
                buttonName: "Edit",
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _oldPasswordTextField(BuildContext context) {
    return viewModel.passwordStates.build(
      buildWhen: (prev, now) {
        return prev.errorStates.oldPasswordErrorText !=
                now.errorStates.oldPasswordErrorText ||
            prev.isPasswordEditMode != now.isPasswordEditMode;
      },
      builder: (context, state) {
        return CustomTextField(
          controller: _oldPasswordController,
          textFieldName: 'old Password',
          enable: state.isPasswordEditMode,
          textFieldType: TextFieldType.password,
          errorText: state.errorStates.oldPasswordErrorText?.getError(),
          onChanged: (password) => viewModel.onChangedOldPassword(
            oldPassword: password,
          ),
        );
      },
    );
  }

  Widget _newPasswordTextField(BuildContext context) {
    return viewModel.passwordStates.build(
      buildWhen: (prev, now) {
        return prev.errorStates.newPasswordErrorText !=
                now.errorStates.newPasswordErrorText ||
            prev.isPasswordEditMode != now.isPasswordEditMode;
      },
      builder: (context, state) {
        return CustomTextField(
          controller: _newPasswordController,
          textFieldName: 'New Password',
          enable: state.isPasswordEditMode,
          textFieldType: TextFieldType.password,
          errorText: state.errorStates.newPasswordErrorText?.getError(),
          onChanged: (newPassword) => viewModel.onChangedNewPassword(
            newPassword: newPassword,
          ),
        );
      },
    );
  }

  Widget _confirmNewPasswordTextField(BuildContext context) {
    return viewModel.passwordStates.build(
      buildWhen: (prev, now) {
        return prev.errorStates.confirmNewPasswordErrorText !=
                now.errorStates.confirmNewPasswordErrorText ||
            prev.isPasswordEditMode != now.isPasswordEditMode;
      },
      builder: (context, state) {
        return CustomTextField(
          controller: _confirmNewPasswordController,
          textFieldName: 'Confirm New Password',
          enable: state.isPasswordEditMode,
          textFieldType: TextFieldType.password,
          errorText: state.errorStates.confirmNewPasswordErrorText?.getError(),
          onChanged: (confirmNewPassword) {
            viewModel.onChangedConfirmNewPassword(
              confirmNewPassword: confirmNewPassword,
            );
          },
        );
      },
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return viewModel.passwordStates.build(
      buildWhen: (prev, now) {
        return prev.showButton != now.showButton ||
            prev.isPasswordEditMode != now.isPasswordEditMode;
      },
      builder: (context, states) {
        return Visibility(
          visible: states.isPasswordEditMode,
          child: PrimaryButton(
            label: 'Update Password',
            onPressed: () {
              clearTextFields();
              viewModel.onTapUpdatePasswordBtn();
            },
            minWidth: double.infinity,
            isDisabled: !states.showButton,
          ),
        );
      },
    );
  }

  Widget _buildSuccessMessage(BuildContext context) {
    return viewModel.passwordStates.buildFor(
      select: (state) => state.showSuccessMessage,
      builder: (context, state) {
        return Visibility(
          visible: state.showSuccessMessage,
          child: Text(
            'Successfully updated the password.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
    );
  }
}
